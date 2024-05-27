part of details_step;

typedef _Parameters = ({bool patientIdValid, bool programSelected});

@controller
class DetailsStepController extends StepController<_Parameters> with _$DetailsStepControllerMixin {
  DetailsStepController._()
      : super((
          patientIdValid: false,
          programSelected: true,
        ));

  @override
  _Parameters get validationValue => (patientIdValid: true, programSelected: true);

  TextEditingController _patientIdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void _onPatientIdChanged(String patientId) {
    setValidationParameters((
      patientIdValid: patientId.length > 0,
      programSelected: validationParameters.programSelected,
    ));
    this.patientId = patientId;
  }

  void _onProgramSelected(String program) {
    setValidationParameters((
      patientIdValid: validationParameters.patientIdValid,
      programSelected: true,
    ));
    this.program = program;
  }
}
