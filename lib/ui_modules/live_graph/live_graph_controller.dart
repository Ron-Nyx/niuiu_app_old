part of live_graph;

typedef GraphBooleans = ({bool raw, bool thetaBandPass});

@controller
class LiveGraphController extends Controller with _$LiveGraphControllerMixin {
  static const int MIN_Y = -40000;
  static const int MAX_Y = 40000;

  LiveGraphController._(
    @input Device? device,
    @input int dataLength,
      @stateController(false) StateController<bool> isListeningDataStateController,
    @stateController(GraphData.empty()) StateController<GraphData> rawGraphDataStateController,
    @stateController(GraphData.empty()) StateController<GraphData> thetaBandPassGraphDataStateController,
  );

  StateController<GraphBooleans> fillBuffersGraphsStateController =
      StateController<GraphBooleans>((raw: false, thetaBandPass: false));

  StateController<GraphBooleans> displayGraphsStateController =
      StateController<GraphBooleans>((raw: false, thetaBandPass: false));

  StateController<bool> displayGraduationsStateController = StateController<bool>(true);

  @override
  void onInit() {
    if (controllerId == 'home_page') {
      keepAlive = true;
    }
    _resetGraphDataStateController();
    // rawGraphDataStateController.state.pushValues(List.generate(dataLength,(i) => [-10000, 10000].rand().toDouble()));
  }

  void _resetGraphDataStateController() {
    rawGraphDataStateController.setState(GraphData.zeros(dataLength));
    thetaBandPassGraphDataStateController.setState(GraphData.zeros(dataLength));
  }

  StreamSubscription<List<int>>? _sensorDataSubscription;
  bool get _isListeningForLiveData => isListeningDataStateController.state;
  bool get _isFillingBufferRaw => fillBuffersGraphsStateController.state.raw;
  bool get _isFillingBufferThetaBandPass => fillBuffersGraphsStateController.state.thetaBandPass;
  bool get _isDisplayingRaw => displayGraphsStateController.state.raw;
  bool get _isDisplayingThetaBandPass => displayGraphsStateController.state.thetaBandPass;
  List<int> _rawBuffer = [];
  List<int> _thetaBandPassBuffer = [];
  bool _emptyingRawBuffer = false;
  Timer? _emptyingRawBufferTimer;
  bool _emptyingThetaBandPassBuffer = false;
  Timer? _emptyingThetaBandPassBufferTimer;

  void listenForLiveDataToggle(bool listen) {
    if (listen) {
      _listenForLiveData();
    } else {
      _stopListeningForLiveData();
    }
  }
  
  void _listenForLiveData() {
    if (_isListeningForLiveData) return;
    isListeningDataStateController.setState(true);
    _sensorDataSubscription = device!.session.getLiveSensorDataStream().listen((readings) {
      print('readings: ${readings.sublist(0,5)}');
      List<int> transformedRawReadings = [];
      if (_isFillingBufferRaw) {
        transformedRawReadings = _transformRawBuffer(readings);
      }
      List<int> transformedThetaBandPassReadings = [];
      if (_isFillingBufferThetaBandPass) {
        transformedThetaBandPassReadings = _transformThetaBandPassBuffer(readings);
      }
      if (_isFillingBufferRaw) {
        _rawBuffer.addAll(transformedRawReadings);
        if (!_emptyingRawBuffer) {
          _startEmptyingRawBuffer();
        }
      }
      if (_isFillingBufferThetaBandPass) {
        _thetaBandPassBuffer.addAll(transformedThetaBandPassReadings);
        if (!_emptyingThetaBandPassBuffer) {
          _startEmptyingThetaBandPassBuffer();
        }
      }
    })
      ..safe(this);
    print('-------------------- listening for live data: _sensorDataSubscription: ${_sensorDataSubscription.hashCode} ');
  }

  /// Closes the sensor data listener and after each graph is all zeroes, stops the buffer-emptying timers
  void _stopListeningForLiveData() {
    if (!_isListeningForLiveData) return;
    isListeningDataStateController.setState(false);
    _sensorDataSubscription?.cancel();
  }

  /// If false, after graph is all zeroes, stops its buffer-emptying timer
  /// If true, either starts a new buffer-emptying timer or prevents the buffer-emptying timer from stopping
  void fillBuffersRawGraphToggle(bool fill) =>
      fillBuffersGraphsStateController.setState((raw: fill, thetaBandPass: _isFillingBufferThetaBandPass));

  /// If false, after graph is all zeroes, stops its buffer-emptying timer
  /// If true, either starts a new buffer-emptying timer or prevents the buffer-emptying timer from stopping
  void fillBuffersThetaBandPassGraphToggle(bool fill) =>
      fillBuffersGraphsStateController.setState((raw: _isFillingBufferRaw, thetaBandPass: fill));

  void displayRawGraphToggle(bool display) =>
      displayGraphsStateController.setState((raw: display, thetaBandPass: _isDisplayingThetaBandPass));

  void displayThetaBandPassGraphToggle(bool display) =>
      displayGraphsStateController.setState((raw: _isDisplayingRaw, thetaBandPass: display));

  List<int> _transformRawBuffer(List<int> readings) {
    return readings;
  }

  Butterworth butterworth = Butterworth()..bandPass(5, 50, 5.75, 3.5);


  List<int> _transformThetaBandPassBuffer(List<int> readings) {
    List<int> transformedReadings = [];
    // for (int reading in readings) {
    //   transformedReadings.add((reading + [-20000, 20000].rand()).clamp(MIN_Y, MAX_Y));
    // }
    for (int reading in readings) {
      transformedReadings.add(butterworth.filter(reading.toDouble()).toInt());
    }
    return transformedReadings;
  }

  void _startEmptyingRawBuffer() {
    _emptyingRawBuffer = true;
    _emptyingRawBufferTimer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      try {
        rawGraphDataStateController
            .setState(rawGraphDataStateController.state.pushValues([_rawBuffer.removeFirst().toDouble()]));
        print('emptying raw buffer (${_rawBuffer.length} left)');
      } on RangeError {
        if (!_isListeningForLiveData || !_isFillingBufferRaw) {
          if (rawGraphDataStateController.state.isAllZeros) {
            _stopEmptyingRawBuffer();
            print('stopped emptying raw buffer');
          }
          else {
            rawGraphDataStateController
                .setState(rawGraphDataStateController.state.pushValues([0]));
            print('adding 0 to raw graph');
          }
        }
      }
    });
  }

  void _stopEmptyingRawBuffer() {
    _emptyingRawBuffer = false;
    _emptyingRawBufferTimer?.cancel();
  }

  void _startEmptyingThetaBandPassBuffer() {
    _emptyingThetaBandPassBuffer = true;
    _emptyingThetaBandPassBufferTimer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      try {
        thetaBandPassGraphDataStateController
            .setState(thetaBandPassGraphDataStateController.state.pushValues([_thetaBandPassBuffer.removeFirst().toDouble()]));
      } on RangeError {
        if (!_isListeningForLiveData || !_isFillingBufferThetaBandPass) {
          if (thetaBandPassGraphDataStateController.state.isAllZeros) {
            _stopEmptyingThetaBandPassBuffer();
          }
          else {
            thetaBandPassGraphDataStateController
                .setState(thetaBandPassGraphDataStateController.state.pushValues([0]));
          }
        }
      }
    });
  }

  void _stopEmptyingThetaBandPassBuffer() {
    _emptyingThetaBandPassBuffer = false;
    _emptyingThetaBandPassBufferTimer?.cancel();
  }

  void displayGraduationsToggle(bool display) {
    displayGraduationsStateController.setState(display);
  }

  @override
  Future<void> onDispose() async {
    _stopListeningForLiveData();
    _stopEmptyingRawBuffer();
    _stopEmptyingThetaBandPassBuffer();
    fillBuffersGraphsStateController.close();
    displayGraphsStateController.close();
  }
}