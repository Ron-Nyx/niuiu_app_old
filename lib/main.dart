import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// import 'package:niuiu_app/enums/enums.dart';
// import 'package:niuiu_app/service_modules/battery/battery.dart';
// import 'package:niuiu_app/service_modules/data_object/data_object.dart';
// import 'package:niuiu_app/service_modules/stimulation/stimulation.dart';
// import 'package:niuiu_app/service_modules/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dart_extensions/dart_extensions.dart';

// import 'package:niuiu_app/enums/type_converters/type_converter_service.dart';
// import 'package:niuiu_app/service_modules/environment/environment.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';

// import 'service_modules/data_object/data_object.dart';
// import 'package:niuiu_app/service_modules/local_database/local_database.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';

// import 'package:niuiu_app/service_modules/audio/audio.dart';
// import 'package:niuiu_app/service_modules/da14531_adapter/da14531_adapter.dart';
// import 'package:niuiu_app/service_modules/da14531_connection/da14531_connection.dart';
// import 'package:niuiu_app/service_modules/ban_communication/ban_communication.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart';

// import 'package:niuiu_app/service_modules/signal_strength/signal_strength.dart';
// import 'service_modules/data_classes/data_classes_module.dart';
// import 'service_modules/text_module/text_service.dart';
import 'package:device_driver/device_driver.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recase/recase.dart';
import 'package:type_converter/type_converter.dart';
import 'package:enums/type_converters/type_converters.dart' as enums;
import 'ui_modules/app.dart';
import 'loading_screen.dart';

// import 'service_modules/data_classes/data_classes_module.dart';
import 'package:window_manager/window_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1500, 800),
    minimumSize: Size(1500, 800),
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(kReleaseMode ? _ReleaseApp() : _DebugApp());
  // runApp(_ReleaseApp());
}

class _TypeConverterService extends TypeConverterService {
  static _TypeConverterService i = _TypeConverterService._();

  _TypeConverterService._();

  init() {
    List<TypeConverter> _typeConverters = [
      ...enums.typeConverters,
    ];
    addBaseTypeConverters();
    addConverters(_typeConverters);
  }
}

Future<void> initServices() async {
  _TypeConverterService.i.init();
  ScreenService.i.init();
  // AudioService.i.init();
  ThemeService.i.init(Themes.DARK);
  await DA14531Adapter.i.init();
  // DataObjectsService.i.init();
  // await StorageService.i.init();
  // await LocalDatabaseService.i.init();
  // print(LocalDatabaseService.i.getTable<LocalSettingsTable>().entries.map((e) => e.toMap()));
  // TextService.i.init();
  // // TextService.i.changeLanguage(Language('de'));
  // await DA14531AdapterService.i.init();
  // await DA14531ConnectionService.i.init();
  // BanCommunicationService.i.init([DA14531ConnectionService.i]);
  // BatteryService.i.init();
  // SignalStrengthService.i.init();
  // StimulationService.i.init();
}

Future<void> _createDefaultDeviceList() async {
  File userFile = File('${Directory.current.path}\\devices\\devices.txt');
  try {
    String userContent = await userFile.readAsString();
    jsonDecode(userContent);
  } catch (ex) {
    print(ex);
    String defaultContent = await rootBundle.loadString('assets/devices/devices.txt');
    if (await userFile.exists()) {
      await userFile.delete();
    }
    await (await userFile.create(recursive: true)).writeAsString(defaultContent);
  }
}

Future<void> cacheImages(BuildContext context) async => await Future.wait([
      // precacheImage(AssetImage('assets/images/nyx_image_2.png'), context),
    ]);

Future<void> cacheSvgs(BuildContext context) async {
  // const nyxImageLoader = const SvgAssetLoader('assets/svgs/nyx_image.svg');
  // svg.cache.putIfAbsent(nyxImageLoader.cacheKey(null), () => nyxImageLoader.loadBytes(null));
  // const nyxLogoLoader = const SvgAssetLoader('assets/svgs/nyx_logo_dark.svg');
  // svg.cache.putIfAbsent(nyxLogoLoader.cacheKey(null), () => nyxLogoLoader.loadBytes(null));
}

Future<PackageInfo> getPackageInfo() async => await PackageInfo.fromPlatform();

Future<void> waitRelease(BuildContext context) async => [
      initServices(),
      _createDefaultDeviceList(),
      cacheImages(context),
      cacheSvgs(context),
      Future.delayed(const Duration(milliseconds: 2000), () => 1),
    ].waitForLast();

class _ReleaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: waitRelease(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasError) {
          throw Error.throwWithStackTrace(snap.error!, snap.stackTrace!);
        }
        return (snap.connectionState == ConnectionState.waiting) ? LoadingScreen() : App();
      });
}

Future<void> waitDebug(BuildContext context) async => [
      initServices(),
      _createDefaultDeviceList(),
      cacheImages(context),
      cacheSvgs(context),
    ].waitForLast();

class _DebugApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: waitDebug(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasError) {
          throw Error.throwWithStackTrace(snap.error!, snap.stackTrace!);
        }
        return (snap.connectionState == ConnectionState.waiting) ? Container() : App();
      });
}
