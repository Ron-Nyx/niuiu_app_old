import 'package:flutter/material.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController openingAnimationController;
  late CurvedAnimation openingAnimation;

  @override
  void initState() {
    openingAnimationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    openingAnimation = CurvedAnimation(parent: openingAnimationController, curve: Curves.easeInSine);
    WidgetsBinding.instance.addPostFrameCallback((_) => openingAnimationController.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Themes.DARK.backgroundColor,
            child: LayoutBuilder(
              builder: (context, constraints) => Center(
                child: FadeTransition(
                  opacity: openingAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.3,
                        child: SvgPicture.asset(
                          'assets/svgs/niura_logo.svg',
                          width: constraints.maxWidth * 0.3,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                      DefaultTextStyle(
                        style: TextStyle(
                            fontFamily: 'Gilroy', color: Color(0xFFF7F7FC), fontSize: constraints.maxHeight * 0.1),
                        child: Column(
                          children: [
                            Text('Niuiu'),
                            SizedBox(height: constraints.maxWidth * 0.015),
                            FutureBuilder(
                              future: PackageInfo.fromPlatform().then((value) => value.version),
                              builder: (context, snapshot) {
                                return AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  child: (snapshot.hasData)
                                      ? Text(
                                          snapshot.data.toString(),
                                          style: TextStyle(fontSize: constraints.maxHeight * 0.04),
                                        )
                                      : Text(''),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
