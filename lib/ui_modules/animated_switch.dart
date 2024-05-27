import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedSwitch extends StatefulWidget {
  final double width;
  final double height;
  final bool turnState;
  final Color? backgroundColor;
  final Color? switchColor;
  final String textOff;
  final String textOn;
  final double? textSize;
  final Color? backgroundColorOn;
  final Color? backgroundColorOff;
  final Color? switchColorOn;
  final Color? switchColorOff;
  final IconData? iconOn;
  final IconData? iconOff;
  final bool rollEffect;
  final Duration animationDuration;
  final Function? onTap;
  final Function(bool)? onChanged;
  final bool enabled;

  AnimatedSwitch({
    this.width = 130,
    this.height = 50,
    this.turnState = false,
    this.backgroundColor,
    this.switchColor,
    this.textOff = '',
    this.textOn = '',
    this.textSize,
    this.backgroundColorOn,
    this.backgroundColorOff,
    this.switchColorOn,
    this.switchColorOff,
    this.iconOff,
    this.iconOn,
    this.rollEffect = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onTap,
    this.onChanged,
    this.enabled = true,
  });

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  late double width;
  late double height;
  late double ratio;
  late double iconDiameter;
  late double padding;
  late double textSize;
  late bool turnState;
  late double value;

  void _initValues() {
    width = widget.width;
    height = widget.height;
    ratio = width / height;
    padding = height / 14;
    iconDiameter = ratio > 1 ? (height - (padding * 2)) : width;
    textSize = widget.textSize ?? width / 10;
    turnState = widget.turnState;
    value = turnState ? 1.0 : 0.0;
  }

  void _setValues() {
    width = widget.width;
    height = widget.height;
    ratio = width / height;
    padding = height / 14;
    iconDiameter = ratio > 1 ? (height - (padding * 2)) : width;
    textSize = widget.textSize ?? width / 10;
    turnState = widget.turnState;

    if (turnState && animation.status == AnimationStatus.dismissed) {
      animationController.forward();
    }
    else if (!turnState && animation.status == AnimationStatus.completed) {
      animationController.reverse();
    }

      else {
      value = turnState ? 1.0 : 0.0;
    }
  }

  @override
  void initState() {
    super.initState();
    _initValues();

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: value,
      duration: widget.animationDuration,
    );
    animation = CurvedAnimation(parent: animationController, curve: Curves.linear)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          widget.onChanged?.call(turnState);
        }

      });
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
//    _determine();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setValues();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColorOn = widget.backgroundColorOn ?? widget.backgroundColor ?? Theme.of(context).primaryColor;
    Color backgroundColorOff = widget.backgroundColorOff ?? widget.backgroundColor ?? Theme.of(context).primaryColor;
    Color? backgroundTransitionColor = Color.lerp(backgroundColorOff, backgroundColorOn, value);
    Color switchColorOn = widget.switchColorOn ?? widget.switchColor ?? Theme.of(context).hoverColor;
    Color switchColorOff = widget.switchColorOff ?? widget.switchColor ?? Theme.of(context).hoverColor;
    Color? switchTransitionColor = Color.lerp(switchColorOff, switchColorOn, value);

    return GestureDetector(
      onTap: () {
        if (widget.enabled) {
          _action();
          if (widget.onTap != null) widget.onTap?.call();
        }
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        width: width,
        height: height,
        decoration: BoxDecoration(color: backgroundTransitionColor, borderRadius: BorderRadius.circular(iconDiameter)),
        child: Stack(
          children: <Widget>[
            /// Text Right
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  height: height,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(color: switchTransitionColor, fontWeight: FontWeight.bold, fontSize: textSize),
                  ),
                ),
              ),
            ),

            /// Text Left
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.centerLeft,
                  height: height,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(color: switchTransitionColor, fontWeight: FontWeight.bold, fontSize: widget.textSize),
                  ),
                ),
              ),
            ),

            /// Icon
            Transform.translate(
              offset: Offset((width - iconDiameter - (padding * 2)) * value, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, widget.rollEffect ? 2 * pi : 0, value) ?? 0.0,
                child: Container(
                  height: iconDiameter,
                  width: iconDiameter,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: switchTransitionColor),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: widget.iconOff != null
                              ? Icon(
                            widget.iconOff,
                            size: 25,
                            color: backgroundTransitionColor,
                          )
                              : null,
                        ),
                      ),
                      Center(
                        child: Opacity(
                            opacity: value.clamp(0.0, 1.0),
                            child: widget.iconOn != null
                                ? Icon(
                              widget.iconOn,
                              size: 21,
                              color: backgroundTransitionColor,
                            )
                                : null),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState) ? animationController.forward() : animationController.reverse();
    });
  }
}
