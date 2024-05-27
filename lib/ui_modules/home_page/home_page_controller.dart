part of home_page;

enum SessionPhase {
  IDLE,
  STARTING,
  IN_PROGRESS,
  ENDING,
}

@controller
class HomePageController extends Controller with _$HomePageControllerMixin {
  HomePageController._(
    @input Device? device,
    @stateController(false) StateController<bool> sessionCaptureStateController,
    @stateController(SessionPhase.IDLE) StateController<SessionPhase> sessionPhaseStateController,
    @stateController(const []) StateController<List<String>> logsStateController,
    @stateController(0) StateController<int> batteryStateController,
    @stateController(false) StateController<bool> liveDataStateController,
  );

  DA14531Module? get da14531Module => device?.bluetooth as DA14531Module?;
  String? patientId;
  StopWatchController stopWatchController = StopWatchController(intervalDuration: const Duration(seconds: 1));

  bool get _sessionCapture => sessionCaptureStateController.state;

  SessionPhase get sessionPhase => sessionPhaseStateController.state;

  bool get _sessionInProgress => sessionPhaseStateController.state == SessionPhase.IN_PROGRESS;
  ScrollController _scrollController = ScrollController();

  late LiveGraphController liveGraphController;

  @override
  void onInit() {
    _listenForAppClosing();
    _listenForDisconnect();
    liveGraphController = $LiveGraph.createController(
      controllerId: 'home_page',
      device: device,
      dataLength: 250,
    )
      ..fillBuffersRawGraphToggle(true)
      ..fillBuffersThetaBandPassGraphToggle(true);
    // WidgetsBinding.instance.addPostFrameCallback((_) => _onStartSessionPressed());
    _listenForSessionCapture();
    _listenForConnectionState();
    _getBatteryPeriodic();

    logsStateController.listen((state) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
      }
    });
  }

  StreamSubscription<DA14531ConnectionEvent>? _connectionPhaseSubscription;
  StreamSubscription<SystemEventType>? _systemEventSubscription;
  StreamSubscription<AnalyzerResultBanDeviceNotification>? _analyzerResultSubscription;
  StreamSubscription<List<int>>? _sensorDataSubscription;
  StreamSubscription<SessionPhase>? _sessionPhaseSubscription;

  void _listenForAppClosing() {
    bool exitAppModalShowing = false;
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      if (exitAppModalShowing) return false;
      showDialog(
          context: context!,
          builder: (context) {
            return ExitAppModal(device: device);
          }).then((_) => exitAppModalShowing = false);
      exitAppModalShowing = true;
      return false;
    });
  }

  void _listenForDisconnect() {
    device?.bluetooth.onDisconnected((event) {
      showDialog(
          context: context!,
          builder: (context) {
            return DisconnectionModal(device: device);
          });
    }).safe(this);
  }

  void _listenForSessionCapture() {
    sessionCaptureStateController.listen((v) {
      if (v) {
        _listenForSessionPhase();
      } else {
        _stopListeningForSessionPhase();
      }
    }).safe(this);
  }

  void _listenForSessionPhase() {
    _sessionPhaseSubscription = sessionPhaseStateController.listen2((state, prevState) {
      if (state == SessionPhase.STARTING) {
        _listenForSystemEventsLogs();
        _listenForAnalyzerResultsLogs();
        _listenForLiveDataLogs();
      } else if (state == SessionPhase.IN_PROGRESS) {
        stopWatchController.start();
        liveGraphController
          ..listenForLiveDataToggle(true)
          ..displayRawGraphToggle(true)
          ..displayThetaBandPassGraphToggle(false);
        windowManager.setTitle('niuiu [${da14531Module!.device.id} (${da14531Module!.bleDevice.address})] [$patientId]');
        windowManager.setIcon('assets\\icons\\niura_logo_red.ico');
      } else if ((state == SessionPhase.ENDING || state == SessionPhase.IDLE) && (prevState == SessionPhase.IN_PROGRESS)) {
        stopWatchController.reset();
        liveGraphController
          ..listenForLiveDataToggle(false)
          ..displayRawGraphToggle(false)
          ..displayThetaBandPassGraphToggle(false);
        windowManager.setTitle('niuiu [${da14531Module!.device.id} (${da14531Module!.bleDevice.address})]');
        windowManager.setIcon('assets\\icons\\niura_logo_black.ico');
        _stopListeningForAnalyzerResultsLogs();
        _stopListeningForLiveDataLogs();
        if (state == SessionPhase.IDLE) {
          _stopListeningForSystemEventsLogs();
        }
      } else if ((state == SessionPhase.IDLE) && (prevState == SessionPhase.ENDING)) {
        _stopListeningForSystemEventsLogs();
      }
    })
      ..safe(this);
  }

  void _stopListeningForSessionPhase() {
    _sessionPhaseSubscription?.cancel();
  }

  void _listenForConnectionState() {
    _connectionPhaseSubscription = da14531Module?.onDisconnected((event) {
      sessionPhaseStateController.setState(SessionPhase.IDLE);
      _stopGettingBattery();
    });
  }

  void _stopListeningForConnectionState() {
    _connectionPhaseSubscription?.cancel();
  }

  void _listenForSystemEventsLogs() {
    _systemEventSubscription = da14531Module?.getIncomingSystemEventStream().listen((event) {
      _logEvent(convert<SystemEventType, String>(event)!);
    });
  }

  void _stopListeningForSystemEventsLogs() {
    _systemEventSubscription?.cancel();
  }

  void _listenForAnalyzerResultsLogs() {
    _analyzerResultSubscription = da14531Module?.getIncomingMessageStream<AnalyzerResultBanDeviceNotification>().listen((notification) {
      _logEvent(convert<AnalyzerType, String>(notification.body.analyzerType)!);
    });
  }

  void _stopListeningForAnalyzerResultsLogs() {
    _analyzerResultSubscription?.cancel();
  }

  void _listenForLiveDataLogs() {
    _sensorDataSubscription = device?.session.getLiveSensorDataStream().listen((event) {
      if (!_sessionInProgress) return;
      _logEvent('Live Data Received');
    });
  }

  void _stopListeningForLiveDataLogs() {
    _sensorDataSubscription?.cancel();
  }

  Timer? _getBatteryTimer;

  void _getBatteryPeriodic() {
    if (da14531Module == null) return;
    _getBattery();
    _getBatteryTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _getBattery();
    });
  }

  Future<void> _getBattery() async {
    bool isError = true;
    late int batteryResult;
    while (isError) {
      try {
        batteryResult = (await da14531Module!.getBattery()).clamp(0, 100);
      } on ErrorBanDeviceResponse {
        continue;
      }
      isError = false;
    }
    batteryStateController.setState(batteryResult);
  }

  void _stopGettingBattery() {
    _getBatteryTimer?.cancel();
  }

  Future<void> _onStartSessionPressed() async {
    RootNavigationService.i.showDialog(builder: (BuildContext context) => $StartSessionModal());
  }

  Future<void> _onStopSessionPressed() async {
    if (!_sessionInProgress) return;
    sessionPhaseStateController.setState(SessionPhase.ENDING);
    await [
      device!.session.sessionStop(),
      da14531Module!.getIncomingSystemEvent(SystemEventType.SESSION_EVENT_SESSION_STOP),
    ].waitForLast();
    sessionPhaseStateController.setState(SessionPhase.IDLE);
  }

  void _logEvent(String event) {
    logsStateController.setState([
      ...logsStateController.state,
      '[ ${DateTime.now().format('HH:mm:ss').replaceAll(':', ' : ')} ] $event',
    ]);
  }

  void _clearLogs() {
    logsStateController.setState([]);
  }

  void _onLiveDataSwitchToggle(bool v) {
    liveGraphController.listenForLiveDataToggle(v);
  }

  void _onRawSwitchToggle(bool v) {
    liveGraphController.displayRawGraphToggle(v);
  }

  void _onThetaBandPassSwitchToggle(bool v) {
    liveGraphController.displayThetaBandPassGraphToggle(v);
  }

  @override
  Future<void> onDispose() async {
    _stopListeningForConnectionState();
    _stopListeningForSessionPhase();
    _stopListeningForSystemEventsLogs();
    _stopListeningForAnalyzerResultsLogs();
    _stopListeningForLiveDataLogs();
    _stopGettingBattery();
    await device?.close();
    super.onDispose();
  }
}
