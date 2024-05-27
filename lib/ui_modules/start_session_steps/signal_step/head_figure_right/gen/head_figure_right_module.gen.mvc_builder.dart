///##################################################
///#### Generated by mvcBuilder - Do Not Modify #####
///##################################################
part of head_figure_right;

ControllerRegistry<HeadFigureRightController> _$registry =
    ControllerRegistry<HeadFigureRightController>();

class $HeadFigureRight extends ViewWrapper {
  const $HeadFigureRight({
    String? controllerId,
    bool forceAttach = false,
  }) : super(controllerId, forceAttach);
  factory $HeadFigureRight.fromController(
    HeadFigureRightController controller, {
    bool forceAttach = false,
  }) {
    return $HeadFigureRight(
      controllerId: controller.controllerId,
      forceAttach: forceAttach,
    );
  }
  @override
  State<StatefulWidget> createState() => _$HeadFigureRightState();
  static HeadFigureRightController createController({
    String? controllerId,
  }) {
    HeadFigureRightController controller = HeadFigureRightController._();
    _$registry.addController(controller, controllerId, () {});
    controller.onInit();
    return controller;
  }

  static HeadFigureRightController getController({required String id}) =>
      _$registry.getControllerStrict(id);
  static HeadFigureRightController getControllerWhere(
          bool Function(HeadFigureRightController) callback) =>
      _$registry.getControllerWhereStrict(callback);
}

class _$HeadFigureRightState extends ViewWrapperState<$HeadFigureRight, HeadFigureRightController> {
  ControllerRegistry<HeadFigureRightController> registry = _$registry;
  View get view => HeadFigureRight._();
  HeadFigureRightController createController(String? controllerId) =>
      $HeadFigureRight.createController(
        controllerId: controllerId,
      );
}

mixin _$HeadFigureRightControllerMixin on Controller {}