part of start_session_loading;

@controller
class StartSessionLoadingController extends Controller with _$StartSessionLoadingControllerMixin, HomePageAccessor {
  StartSessionLoadingController._(
    @input String patientId,
    @input String program,
    @input SessionConfiguration sessionConfiguration,
  );

  @override
  void onInit() {
    _waitToStopLoading();
  }

  late String _sessionName;

  Future<void> _startSession() async {
    _sessionName = '${DateTime.now().secondsSinceEpoch}_${patientId}_se';
    await device?.session.sessionStart(
      _sessionName,
      sessionConfiguration,
    );
  }

  Future _listenForSessionStartEvent() async =>
      await device?.bluetooth.getIncomingSystemEvent(SystemEventType.SESSION_EVENT_SESSION_START);

  Future<void> _waitToStopLoading() async {
    homePageController.sessionCaptureStateController.setState(true);
    await Future.delayed(Duration(milliseconds: 20)); // hack
    homePageController.sessionPhaseStateController.setState(SessionPhase.STARTING);
    try {
      await [
        [
          _startSession(),
          _listenForSessionStartEvent(),
        ].waitForLast().then((value) {
          homePageController.patientId = patientId;
        }),
        Future.delayed(Duration(milliseconds: 1200)),
      ].waitForLast();
      homePageController.sessionPhaseStateController.setState(SessionPhase.IN_PROGRESS);
      _saveSessionConfiguration();
      _saveSessionMetaData();
    } on ErrorBanDeviceResponse catch (ex) { // For handling silly battery error responses that interject the session start process. Requires transactionId to counter
      if (ex.body.deviceError == DeviceError.BATTERY_ERROR) {
        homePageController.sessionPhaseStateController.setState(SessionPhase.IN_PROGRESS);
        _saveSessionConfiguration();
        _saveSessionMetaData();
      }
    } catch (ex, stackTrace) {
      print('@' * 100 + '[$ex]' + '[${ex.runtimeType}]' + '${stackTrace}');
    }
    RootNavigationService.i.pop();
  }

  Future<void> _saveSessionConfiguration() async {
    String sessionConfigurationJson = jsonEncodeWithToString(sessionConfiguration.toMap());
    Directory directory = await createDirectory('${Directory.current.path}\\sessions\\${_sessionName}');
    File sessionConfigurationFile = File('${directory.path}\\session_configuration.json');
    await sessionConfigurationFile.writeAsString(sessionConfigurationJson);
  }

  Future<void> _saveSessionMetaData() async {
    Map<String, dynamic> clientInfo = (await DeviceInfoPlugin().windowsInfo).data
      ..removeWhere((k, v) {
        return !['computerName', 'productName'].contains(k);
      });
    clientInfo = clientInfo.map((k, v) => MapEntry(k.snakeCase, v));
    Map<String, dynamic> metaData = {
      'device_id': da14531Module!.bleDevice.address,
      'device_name': device!.id,
      'client_info': clientInfo,
      'time_zone_name': DateTime.now().timeZoneName,
      'time_zone_offset': DateTime.now().timeZoneOffset.inHours,
      'department': 'Nyx',
      'program': 'korea_experiment_1',
      'patient_id': patientId,
      'condition': program,
    };
    String metaDataJson = jsonEncodeWithToString(metaData);
    Directory directory = await createDirectory('${Directory.current.path}\\sessions\\${_sessionName}');
    File metaDataFile = File('${directory.path}\\meta_data_app.json');
    await metaDataFile.writeAsString(metaDataJson);
  }
}

Future<Directory> createDirectory(String path) async {
  Directory dir = Directory(path);
  bool dirExists = await dir.exists();
  if (!dirExists) {
    await dir.create(recursive: true);
  }
  return dir;
}

Future<File> createFile(String path, Uint8List rawData) async => File(path).writeAsBytes(rawData);

String jsonEncodeWithToString(Map<String, dynamic> map) {
  final modifiedMap = map.deepValuesMap((value) => value.toString());
  return JsonEncoder.withIndent(' ').convert(modifiedMap);
}
