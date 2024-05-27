///##################################################
///#### Generated by mvcBuilder - Do Not Modify #####
///##################################################
part of start_session_loading;

ControllerRegistry<StartSessionLoadingController> _$registry =
    ControllerRegistry<StartSessionLoadingController>();

class $StartSessionLoading extends ViewWrapper {
  final String patientId;
  final String program;
  final SessionConfiguration sessionConfiguration;
  const $StartSessionLoading({
    String? controllerId,
    bool forceAttach = false,
    required this.patientId,
    required this.program,
    required this.sessionConfiguration,
  }) : super(controllerId, forceAttach);
  factory $StartSessionLoading.fromController(
    StartSessionLoadingController controller, {
    bool forceAttach = false,
  }) {
    return $StartSessionLoading(
      controllerId: controller.controllerId,
      forceAttach: forceAttach,
      patientId: controller.patientId,
      program: controller.program,
      sessionConfiguration: controller.sessionConfiguration,
    );
  }
  @override
  State<StatefulWidget> createState() => _$StartSessionLoadingState();
  static StartSessionLoadingController createController({
    String? controllerId,
    required String patientId,
    required String program,
    required SessionConfiguration sessionConfiguration,
  }) {
    StartSessionLoadingController controller = StartSessionLoadingController._(
      patientId,
      program,
      sessionConfiguration,
    );
    controller.patientId = patientId;
    controller.program = program;
    controller.sessionConfiguration = sessionConfiguration;
    _$registry.addController(controller, controllerId, () {});
    controller.onInit();
    return controller;
  }

  static StartSessionLoadingController getController({required String id}) =>
      _$registry.getControllerStrict(id);
  static StartSessionLoadingController getControllerWhere(
          bool Function(StartSessionLoadingController) callback) =>
      _$registry.getControllerWhereStrict(callback);
}

class _$StartSessionLoadingState
    extends ViewWrapperState<$StartSessionLoading, StartSessionLoadingController> {
  ControllerRegistry<StartSessionLoadingController> registry = _$registry;
  View get view => StartSessionLoading._();
  StartSessionLoadingController createController(String? controllerId) =>
      $StartSessionLoading.createController(
        controllerId: controllerId,
        patientId: widget.patientId,
        program: widget.program,
        sessionConfiguration: widget.sessionConfiguration,
      );
}

mixin _$StartSessionLoadingControllerMixin on Controller {
  late String patientId;
  late String program;
  late SessionConfiguration sessionConfiguration;
}