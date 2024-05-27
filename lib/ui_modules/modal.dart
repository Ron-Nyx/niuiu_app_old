import 'package:flutter/material.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';

class Modal extends StatelessWidget {
  final Widget content;
  final double padding;

  Modal({
    required this.content,
    double? padding,
  }) : padding = padding ?? 40;

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ThemeService.i.themeModel.gray2,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(padding),
                child: content,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
