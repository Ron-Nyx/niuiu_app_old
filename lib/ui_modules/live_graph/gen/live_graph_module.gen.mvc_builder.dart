///##################################################
///#### Generated by mvcBuilder - Do Not Modify #####
///##################################################
part of live_graph;

ControllerRegistry<LiveGraphController> _$registry = ControllerRegistry<LiveGraphController>();

class $LiveGraph extends ViewWrapper {
  final Device? device;
  final int dataLength;
  const $LiveGraph({
    String? controllerId,
    bool forceAttach = false,
    required this.device,
    required this.dataLength,
  }) : super(controllerId, forceAttach);
  factory $LiveGraph.fromController(
    LiveGraphController controller, {
    bool forceAttach = false,
  }) {
    return $LiveGraph(
      controllerId: controller.controllerId,
      forceAttach: forceAttach,
      device: controller.device,
      dataLength: controller.dataLength,
    );
  }
  @override
  State<StatefulWidget> createState() => _$LiveGraphState();
  static LiveGraphController createController({
    String? controllerId,
    required Device? device,
    required int dataLength,
  }) {
    LiveGraphController controller = LiveGraphController._(
      device,
      dataLength,
      StateController<bool>(false),
      StateController<GraphData>(null),
      StateController<GraphData>(null),
    );
    controller.device = device;
    controller.dataLength = dataLength;
    controller.isListeningDataStateController = StateController<bool>(false);
    controller.rawGraphDataStateController = StateController<GraphData>(null);
    controller.thetaBandPassGraphDataStateController = StateController<GraphData>(null);
    _$registry.addController(controller, controllerId, () {
      controller.isListeningDataStateController.close();
      controller.rawGraphDataStateController.close();
      controller.thetaBandPassGraphDataStateController.close();
    });
    controller.onInit();
    return controller;
  }

  static LiveGraphController getController({required String id}) =>
      _$registry.getControllerStrict(id);
  static LiveGraphController getControllerWhere(bool Function(LiveGraphController) callback) =>
      _$registry.getControllerWhereStrict(callback);
}

class _$LiveGraphState extends ViewWrapperState<$LiveGraph, LiveGraphController> {
  ControllerRegistry<LiveGraphController> registry = _$registry;
  View get view => LiveGraph._();
  LiveGraphController createController(String? controllerId) => $LiveGraph.createController(
        controllerId: controllerId,
        device: widget.device,
        dataLength: widget.dataLength,
      );
}

mixin _$LiveGraphControllerMixin on Controller {
  late Device? device;
  late int dataLength;
  late StateController<bool> isListeningDataStateController;
  late StateController<GraphData> rawGraphDataStateController;
  late StateController<GraphData> thetaBandPassGraphDataStateController;
}
