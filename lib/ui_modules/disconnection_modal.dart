import 'dart:io';
import 'package:flutter/material.dart' hide Dialog;
import 'package:device_driver/device_driver.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/service_modules/scaffold/scaffold.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide Dialog;
import 'package:niuiu_app/ui_modules/modal.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DisconnectionModal extends StatelessWidget {
  final Device? device;

  DisconnectionModal({
    Key? key,
    required this.device,
  }) : super(key: key);

  Future<void> _ok() async {
    RootNavigationService.i.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      padding: 40,
      content: Column(
        children: [
          /// title
          Container(
            width: 300,
            child: Text(
              'Connection with device "${device?.id}" was lost',
              style: TextStyle(
                fontSize: 24,
                color: ThemeService.i.themeModel.textColor2,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // /// subtitle
          // Container(
          //   child: Text(
          //     '',
          //     style: TextStyle(fontSize: ScreenService.i.pixelRelHeight(28)),
          //   ),
          //   margin: EdgeInsets.only(top: ScreenService.i.pixelRelHeight(40.42)),
          // ),

          SizedBox(height: 30),

          /// buttons
          Container(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// OK button
                Container(
                  width: 155,
                  height: 47,
                  child: MaterialButton(
                    onPressed: _ok,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: ThemeService.i.themeModel.primaryColor,
                    hoverColor: ThemeService.i.themeModel.primaryColor2,
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeService.i.themeModel.textColor2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
