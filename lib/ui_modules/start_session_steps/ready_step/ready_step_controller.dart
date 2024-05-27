part of ready_step;

@controller
class ReadyStepController extends StepController<bool> with _$ReadyStepControllerMixin {
  ReadyStepController._() : super(true);

  @override
  bool get validationValue => true;
}