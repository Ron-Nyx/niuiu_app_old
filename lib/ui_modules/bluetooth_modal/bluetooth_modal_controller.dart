part of bluetooth_modal;

@controller
class BluetoothModalController extends Controller with _$BluetoothModalControllerMixin {
  BluetoothModalController._(
    @stateController('') StateController<String> statusTextStateController,
    @stateController() StateController<UnmodifiableListView<Device>> discoveredDevicesStateController,
    @stateController() StateController<Device?> selectedDeviceStateController,
  );

  UnmodifiableListView<Device> get discoveredDevices => discoveredDevicesStateController.state;

  Device? get selectedDevice => selectedDeviceStateController.state;

  DA14531Module? get selectedModule => selectedDevice?.bluetooth as DA14531Module?;

  StreamSubscription? _connectingStatusSubscription;

  static Map<String, dynamic>? _deviceNameMap;

  static Future<Map<String, dynamic>?> get deviceNameMap async {
    if (_deviceNameMap != null) return _deviceNameMap!;
    File file = File('${Directory.current.path}\\devices\\devices.txt');
    String content = await file.readAsString();
    return _deviceNameMap = jsonDecode(content);
  }

  static Future<String> _getDeviceId(DA14531Module da14531module) async {
    String address = da14531module.bleDevice.address.toUpperCase();
    String? name = (await deviceNameMap)?[address];
    return name ?? '${da14531module.bleDevice.name!} (${address.substring(address.length - 2).toUpperCase()})';
  }

  @override
  void onInit() {
    _clearDiscovered();
    _startDiscovering();
  }

  void _startDiscovering() {
    DA14531Adapter.i.discover().listen((da14531Module) async {
      Device device = Device(
        id: await _getDeviceId(da14531Module),
        bluetooth: da14531Module,
      );
      await device.init();
      discoveredDevicesStateController.setState(UnmodifiableListView([...discoveredDevices, device]));
    }).safe(this);
  }

  void _clearDiscovered() {
    discoveredDevicesStateController.setState(UnmodifiableListView([]));
  }

  Future<void> exitModal() async {
    RootNavigationService.i.pop();
  }

  void _onDeviceSelected(Device device) {
    _connectingStatusSubscription?.cancel();
    selectedDeviceStateController.setState(device);
  }

  void _onConnectPressed(Device selectedDevice) async {
    await DA14531Adapter.i.stopDiscovery();
    DA14531ConnectionProcess process = selectedModule!.connect(ConnectionConfiguration(
      firmwareVersion: '1.9.0',
      da14531ConnectionDiscovery: false,
      da14531ConnectionVersionValidation: true,
      da14531ConnectionBatteryNotifications: false,
    ))!
      ..onUpdate(
          type: ProcessUpdateType.STAGE_START,
          callback: (update) {
            statusTextStateController.setState(_getConnectingStatusText(update.stage));
          })
      ..onSuccess(() {
        statusTextStateController.setState('Connected');
        RootNavigationService.i.pop();
        MainNavigationService.i.push(MainRoutes.HOME, navigationSettings: NavigationSettings(args: selectedDevice));
        windowManager.setTitle('niuiu [${selectedModule!.device.id} (${selectedModule!.bleDevice.address})]');
      })
      ..onFail(() {
        statusTextStateController.setState('Scanning...');
        _clearDiscovered();
        _startDiscovering();
      });
  }

  static const Map<String, String> _connectingStatusMap = {
    DA14531ConnectionProcess.DISCOVER: 'Discovering...',
    DA14531ConnectionProcess.CONNECT_TO_BLE: 'Connecting to BLE...',
    DA14531ConnectionProcess.DISCOVER_SERVICES: 'Discovering BLE Services...',
    DA14531ConnectionProcess.GET_CHARACTERISTICS: 'Getting Characteristics...',
    DA14531ConnectionProcess.REQUEST_MTU: 'Requesting MTU...',
    DA14531ConnectionProcess.ENABLE_CHARACTERISTICS_NOTIFICATION: 'Enabling Notifications...',
    DA14531ConnectionProcess.WRITE_TO_DSPS_FLOW_CONTROL: 'Writing to DSPS Flow Control...',
    DA14531ConnectionProcess.RECEIVE_BINREQ: 'Receiving BINREQ...',
    DA14531ConnectionProcess.SEND_BINREQACK: 'Sending BINREQACK...',
    DA14531ConnectionProcess.RECEIVE_OK: 'Receiving OK...',
    DA14531ConnectionProcess.VALIDATE_VERSION: 'Validating Version',
    DA14531ConnectionProcess.REQUEST_BATTERY_NOTIFICATIONS: 'Requesting Battery Notifications...',
  };

  String _getConnectingStatusText(String? currStage) {
    if (currStage != null) {
      if (_connectingStatusMap[currStage] != null) {
        return _connectingStatusMap[currStage]!;
      } else {
        DA14531ConnectionProcess connectionProcess = selectedModule!.connectionProcess!;
        String? prevStage = connectionProcess.stageBefore(currStage)?.name;
        return _getConnectingStatusText(prevStage);
      }
    }
    return 'Connecting...';
  }

  @override
  Future<void> onDispose() async {
    await Future.forEach(discoveredDevices, (device) async {
      if (!device.bluetooth.isConnected) {
        await device.close();
      }
    });
  }
}
