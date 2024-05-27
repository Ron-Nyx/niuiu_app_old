part of start_session_modal;

mixin _StartSessionModalAccessor {
  StartSessionModalController get startSessionModalController => $StartSessionModal.getControllerWhere((c) => true);

  void showNextButton() => startSessionModalController.showNextButton();

  void hideNextButton() => startSessionModalController.hideNextButton();

  void toggleShowNextButton(bool v) => v ? showNextButton() : hideNextButton();

  void enableNextButton() => startSessionModalController.enableNextButton();

  void disableNextButton() => startSessionModalController.disableNextButton();

  void toggleEnableNextButton(bool v) => v ? enableNextButton() : disableNextButton();

  Future<void> exitModal(bool success) => startSessionModalController.exitModal(success);

  Device? get device => startSessionModalController.device;
  String? get patientId => startSessionModalController.patientId;
  set patientId(String? patientId) => startSessionModalController.patientId = patientId;
  String? get program => startSessionModalController.program;
  set program(String? program) => startSessionModalController.program = program;
  int? get maxStrengthPercentage => startSessionModalController.maxStrengthPercentage;
  set maxStrengthPercentage(int? maxStrengthPercentage) => startSessionModalController.maxStrengthPercentage = maxStrengthPercentage;
}

abstract class StepController<T> extends Controller with _StartSessionModalAccessor {
  final StateController<T> _validationParametersStateController;
  final StateController<bool> _stepValidatedStateController = StateController<bool>(false);

  StepController(T initialValidationParameters) : _validationParametersStateController = StateController<T>(initialValidationParameters);

  void _listenForValidationParametersChange() {
    _toggleStepValidation(_validationParametersStateController.state == validationValue);
    _validationParametersStateController.listen((params) {
      _toggleStepValidation(params == validationValue);
    }).safe(this);
  }

  void _listenForStepValidationChange() {
    _stepValidatedStateController.listen((v) {
      toggleEnableNextButton(v);
    }).safe(this);
  }

  bool _toggleStepValidation(bool v) => _stepValidatedStateController.setState(v, true);

  bool get isStepValidated => _stepValidatedStateController.state;

  T get validationValue;

  T get validationParameters => _validationParametersStateController.state;

  void setValidationParameters(T params) => _validationParametersStateController.setState(params);

  FutureOr<void> onValidation() => null;

  FutureOr<bool> onNext() => true;

  FutureOr<void> onModalExit(bool success) => null;

  FutureOr<void> onModalExitSuccess() => null;

  FutureOr<void> onModalExitFail() => null;

  @override
  @mustCallSuper
  void onInit() {
    _listenForStepValidationChange();
    _listenForValidationParametersChange();
  }
}
