part of sensitivity_step;

enum StimulationPhase {
  IDLE,
  STARTING,
  IN_PROGRESS,
  ENDING,
}

typedef _Parameters = ({bool progressIsZero, bool sessionInProgress});

@controller
class SensitivityStepController extends StepController<_Parameters> with _$SensitivityStepControllerMixin {
  SensitivityStepController._(
    @stateController(0) StateController<double> progressStateController,
      @stateController(StimulationPhase.IDLE) StateController<StimulationPhase> stimulationPhaseStateController,
  ) : super((progressIsZero: true, sessionInProgress: false));

  @override
  _Parameters get validationValue => (progressIsZero: false, sessionInProgress: false);

  @override
  void onInit() {
    super.onInit();
    _listenForSessionStartEvents();
    _listenForSessionStopEvents();
    _listenToProgressStateController();
    _listenForStimulationResultEvents();
    _listenToStimulationPhaseStateController();
  }

  static const int MAX_STRENGTH = 75;
  double _progressTick = 100 / MAX_STRENGTH;

  bool get _isIdle => stimulationPhaseStateController.state == StimulationPhase.IDLE;

  void _listenForSessionStartEvents() {
    device?.bluetooth.getIncomingSystemEventStream([SystemEventType.SESSION_EVENT_SESSION_START])
        .listen((event) {
      progressStateController.setState(0);
      stimulationPhaseStateController.setState(StimulationPhase.IN_PROGRESS);
    }).safe(this);
  }

  void _listenForSessionStopEvents() {
    device?.bluetooth.getIncomingSystemEventStream([SystemEventType.SESSION_EVENT_SESSION_STOP])
        .listen((event) {
      stimulationPhaseStateController.setState(StimulationPhase.IDLE);
    }).safe(this);
  }

  void _listenToProgressStateController() {
    progressStateController.listen((progress) {
      setValidationParameters((
        progressIsZero: progress == 0,
        sessionInProgress: validationParameters.sessionInProgress,
      ));
      maxStrengthPercentage = max((progress / _progressTick).round() - 3, 1);
      if (progress == 100 && !_isIdle) {
        _stopSession();
      }
    });
  }

  void _listenForStimulationResultEvents() {
    device?.bluetooth.getIncomingAnalyzerResultStream(AnalyzerType.STIMULATION_THRESHOLD)
        .map((notification) => notification.body.results[0])
        .listen((strengthPercentage) {
      progressStateController.setState(strengthPercentage * _progressTick);
    }).safe(this);
  }

  void _listenToStimulationPhaseStateController() {
    stimulationPhaseStateController.listen((stimulationPhase) {
      setValidationParameters((
        progressIsZero: validationParameters.progressIsZero,
        sessionInProgress: stimulationPhase != StimulationPhase.IDLE,
      ));
    }).safe(this);
  }

  Future<void> _startSession() async {
    stimulationPhaseStateController.setState(StimulationPhase.STARTING);
    try {
      await device?.session.sessionStart(
        '${DateTime
            .now()
            .secondsSinceEpoch}_${patientId}_th',
        sessionConfigurationMap['sensitivity']!(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<void> _stopSession() async {
    stimulationPhaseStateController.setState(StimulationPhase.ENDING);
    try {
      await device?.session.sessionStop();
    } catch (ex) {
      print(ex);
    }
  }

  void _onTestSensitivityButtonPressed() {
    _startSession();
  }

  void _onStopButtonPressed() {
    _stopSession();
  }

  @override
  Future<void> onModalExitFail() async {
    if (stimulationPhaseStateController.state == StimulationPhase.IN_PROGRESS)
    _stopSession();
  }
}