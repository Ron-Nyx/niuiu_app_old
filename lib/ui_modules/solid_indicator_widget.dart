import 'package:flutter/material.dart';
import 'package:color/color.dart' as color;

class SolidIndicatorWidget extends StatelessWidget {
  static const double BORDER_FACTOR = 0.0588;
  static const double INNER_FACTOR = 0.7;

  final Color _color;
  final double _outerSize;
  final double _outerThickness;
  final double _innerSize;
  final EdgeInsets? _margin;
  final EdgeInsets? _padding;

  const SolidIndicatorWidget({
    Key? key,
    required Color color,
    required double size,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double innerFactor = INNER_FACTOR,
  })  : _color = color,
        _outerSize = size,
        _outerThickness = size * BORDER_FACTOR,
        _innerSize = size * innerFactor,
        _margin = margin,
        _padding = padding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color innerColor = _color;
    color.RgbColor innerRGB = color.RgbColor(innerColor.red, innerColor.green, innerColor.blue);
    color.HslColor innerHSL = innerRGB.toHslColor();
    color.HslColor outerHSL = color.HslColor(innerHSL.h, innerHSL.s, innerHSL.l * 1.15);
    color.RgbColor outerRGB = outerHSL.toRgbColor();
    Color outerColor = Color.fromRGBO(outerRGB.r.toInt(), outerRGB.g.toInt(), outerRGB.b.toInt(), 1);
    return Container(
      width: _outerSize,
      height: _outerSize,
      margin: _margin,
      padding: _padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_outerSize),
        border: Border.all(
          width: _outerThickness,
          color: outerColor,
        ),
      ),
      // margin: EdgeInsets.only(
      //   right: ScreenService.i.pixelRelWidth(6.62),
      // ),
      child: Center(
        child: Container(
          width: _innerSize,
          height: _innerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_innerSize),
            color: innerColor,
          ),
        ),
      ),
    );
  }
}