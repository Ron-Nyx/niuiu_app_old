import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:niuiu_app/ui_modules/background/background_module.dart';
import 'package:niuiu_app/ui_modules/app_bar/app_bar_module.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print(ScreenService.i.screenDetails.safeAreaHeight);
    return StateConsumer<ScreenDetails>(
      controller: ScreenService.i.screenDetailsStateController,
      builder: (context, v) {
        return StateConsumer<ThemeModel>(
          controller: ThemeService.i.themeModelStateController,
          builder: (context, themeModel) {
            return MaterialApp(
              title: 'Clinical Trials App',
              debugShowCheckedModeBanner: false,
              navigatorKey: RootNavigationService.i.navigatorKey,
              theme: themeModel.themeData,
              home: WillPopScope(
                onWillPop: () async => !await MainNavigationService.i.navigatorKey.currentState!.maybePop(),
                child: DefaultTextStyle(
                  style: ThemeService.i.themeModel.themeData.textTheme.bodyLarge!,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SafeArea(
                      child: Stack(
                        children: [
                          /// background
                          $Background(),
                          Center(
                            child: Container(
                              width: 1440,
                              height: 1024,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              // padding: EdgeInsets.symmetric(horizontal: 133),
                              child: Center(
                                child: Container(
                                    child: Stack(
                                  children: [
                                    /// content
                                    Container(
                                      color: Colors.transparent,
                                      child: MainNavigationService.i
                                          .navigator(initialRoute: MainNavigationService.INITIAL_ROUTE),
                                    ),

                                    /// app bar
                                    $AppBar(controllerId: 'app_bar'),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
