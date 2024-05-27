import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:device_driver/device_driver.dart';

Future<void> initServices() async {
  ScreenService.i.init();
  ThemeService.i.init(Themes.DARK);
  await DA14531Adapter.i.init();
}