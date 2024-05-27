part of signal_step;

typedef _Parameters = ({bool stableCountValid});

@controller
class SignalStepController extends StepController<_Parameters> with _$SignalStepControllerMixin {
  SignalStepController._(
    @stateController(SignalStatus.IDLE) StateController<SignalStatus> signalStatusController,
  ) : super((stableCountValid: false,));

  @override
  _Parameters get validationValue => (stableCountValid: true);

  late LiveGraphController liveGraphController;

  @override
  void onInit() {
    super.onInit();
    liveGraphController = $LiveGraph.createController(
      controllerId: 'signal_step',
      device: device,
      dataLength: 120,
    )
      ..fillBuffersRawGraphToggle(true)
      ..displayRawGraphToggle(true)
      ..displayGraduationsToggle(false)
      ..listenForLiveDataToggle(true);

    _listenForSnrResultEvents();
    _listenForStability();
    _startSession();
  }

  void _listenForSnrResultEvents() {
    int stableCount = 0;
    final int stableTicks = 3;
    device?.bluetooth
        .getIncomingAnalyzerResultStream(AnalyzerType.SNR)
        .map((notification) => notification.body.results[0])
        .listen((score) {
      if (score == 1) {
        stableCount++;
        signalStatusController.setState((stableCount >= stableTicks) ? SignalStatus.STABLE : SignalStatus.STABILIZING);
      } else {
        stableCount = 0;
        signalStatusController.setState(SignalStatus.BAD);
      }
    }).safe(this);
  }

  void _listenForStability() {
    signalStatusController.listen((signalStatus) {
      setValidationParameters((
        // stableCountValid: signalStatus == SignalStatus.STABLE
        stableCountValid: signalStatus != SignalStatus.IDLE
      ));
    }).safe(this);
  }

  Future<void> _startSession() async {
    device?.session.sessionStart(
      '${DateTime.now().secondsSinceEpoch}_${patientId}_snr',
      sessionConfigurationMap['snr']!(),
    );
  }

  Future<void> _sessionStop() async {
    await device?.session.sessionStop();
  }

  @override
  Future<bool> onNext() async {
    _sessionStop();
    return true;
  }

  @override
  Future<void> onModalExitFail() async {
    _sessionStop();
  }
}
