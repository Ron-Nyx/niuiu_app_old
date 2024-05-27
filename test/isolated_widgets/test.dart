import 'package:dart_extensions/dart_extensions.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:window_manager/window_manager.dart';
import 'init_services.dart';
import 'widgets/disconnection_modal.dart';
import 'widgets/exit_app_modal.dart';
import 'widgets/live_graph.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1500, 800),
    minimumSize: Size(1500, 800),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(_WidgetTestApp());
}

class _WidgetTestApp extends HookWidget {

  Future<void> wait() async => [
        initServices(),
      ].waitForLast();

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: wait(),
      builder: (BuildContext context, AsyncSnapshot snap) => (snap.connectionState == ConnectionState.waiting) ? Container() : widget);
}

Widget widget = MaterialApp(
  navigatorKey: RootNavigationService.i.navigatorKey,
  theme: ThemeService.i.themeModel.themeData,
  home: DefaultTextStyle(
    style: ThemeService.i.themeModel.themeData.textTheme.bodyText1!,
    child: exitAppModal,
  ),
);