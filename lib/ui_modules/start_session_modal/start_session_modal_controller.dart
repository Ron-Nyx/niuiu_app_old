part of start_session_modal;

@controller
class StartSessionModalController extends Controller with _$StartSessionModalControllerMixin, HomePageAccessor {
  StartSessionModalController._(
    @stateController(Step.DETAILS) StateController<Step> stepStateController,
    @stateController(true) StateController<bool> showNextButtonStateController,
    @stateController(false) StateController<bool> enableNextButtonStateController,
  );

  // Device? _device;
  //
  // Device? get device => _device ??= $HomePage.getControllerWhere((_) => true).device;

  String? patientId = 'RK';
  String? program = 'Sleep induction: Theta';
  int? maxStrengthPercentage;

  Map<Step, StepController Function()> _stepControllerMap = {
    Step.DETAILS: () => $DetailsStep.getControllerWhere((_) => true),
    Step.SIGNAL: () => $SignalStep.getControllerWhere((_) => true),
    Step.SENSITIVITY: () => $SensitivityStep.getControllerWhere((_) => true),
    Step.READY: () => $ReadyStep.getControllerWhere((_) => true),
  };

  Map<Step, ViewWrapper Function()> _stepWidgetMap = {
    Step.DETAILS: () => $DetailsStep(),
    Step.SIGNAL: () => $SignalStep(),
    Step.SENSITIVITY: () => $SensitivityStep(),
    Step.READY: () => $ReadyStep(),
  };

  Step get _currStep => stepStateController.state;

  StepController get _currStepController => _stepControllerMap[_currStep]!();

  ViewWrapper get _currStepWidget => _stepWidgetMap[_currStep]!();

  @override
  void onInit() {
    homePageController.sessionCaptureStateController.setState(false);
  }

  StepController _getStepController(Step step) => _stepControllerMap[step]!();

  ViewWrapper _getStepWidget(Step step) => _stepWidgetMap[step]!();

  void showNextButton() => showNextButtonStateController.setState(true);

  void hideNextButton() => showNextButtonStateController.setState(false);

  void enableNextButton() => enableNextButtonStateController.setState(true, true);

  void disableNextButton() => enableNextButtonStateController.setState(false, true);

  Future<void> _onNextPressed() async {
    if (enableNextButtonStateController.state) {
      if (await _currStepController.onNext()) {
        _currStep.isLast ? exitModal(true) : _nextStep();
      }
    }
  }

  Future<void> _nextStep() async {
    Step? nextStep = _currStep.next;
    if (nextStep != null) {
      stepStateController.setState(nextStep);
    }
  }

  Future<void> exitModal(bool success) async {
    await _invokeStepControllerTrialExitCallbacks(success);
    RootNavigationService.i.pop();
    if (success) {
      RootNavigationService.i.showDialog(
          barrierColor: const Color(0x90000000),
          barrierDismissible: false,
          builder: (BuildContext context) => $StartSessionLoading(
                patientId: patientId!,
                program: program!,
                sessionConfiguration: sessionConfigurationMap[program!]!({
                  'maxStrengthPercentage': maxStrengthPercentage,
                  'stimulationStartTime': Duration(minutes: 5),
                  'stimulationDuration': Duration(minutes: 20),
                }),
              ));
    }
  }

  Future<void> _invokeStepControllerTrialExitCallbacks(bool success) async {
    List<StepController> stepControllers = [];

    for (Step step in Step.values) {
      StepController stepController;
      try {
        stepController = _getStepController(step);
      } catch (ex) {
        continue;
      }
      stepControllers.add(stepController);
    }

    await Future.forEach<StepController>(stepControllers, (stepController) async {
      await (success ? stepController.onModalExitSuccess() : stepController.onModalExitFail());
      await stepController.onModalExit(success);
    });
  }

  @override
  Future<void> onDispose() async {
    homePageController.sessionCaptureStateController.setState(true);
  }
}
