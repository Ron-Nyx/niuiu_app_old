///##################################################
///#### Generated by mvcBuilder - Do Not Modify #####
///##################################################
part of welcome_page;

ControllerRegistry<WelcomePageController> _$registry = ControllerRegistry<WelcomePageController>();

class $WelcomePage extends ViewWrapper {
  const $WelcomePage({
    String? controllerId,
    bool forceAttach = false,
  }) : super(controllerId, forceAttach);
  factory $WelcomePage.fromController(
    WelcomePageController controller, {
    bool forceAttach = false,
  }) {
    return $WelcomePage(
      controllerId: controller.controllerId,
      forceAttach: forceAttach,
    );
  }
  @override
  State<StatefulWidget> createState() => _$WelcomePageState();
  static WelcomePageController createController({
    String? controllerId,
  }) {
    WelcomePageController controller = WelcomePageController._();
    _$registry.addController(controller, controllerId, () {});
    controller.onInit();
    return controller;
  }

  static WelcomePageController getController({required String id}) =>
      _$registry.getControllerStrict(id);
  static WelcomePageController getControllerWhere(bool Function(WelcomePageController) callback) =>
      _$registry.getControllerWhereStrict(callback);
}

class _$WelcomePageState extends ViewWrapperState<$WelcomePage, WelcomePageController> {
  ControllerRegistry<WelcomePageController> registry = _$registry;
  View get view => WelcomePage._();
  WelcomePageController createController(String? controllerId) => $WelcomePage.createController(
        controllerId: controllerId,
      );
}

mixin _$WelcomePageControllerMixin on Controller {}
