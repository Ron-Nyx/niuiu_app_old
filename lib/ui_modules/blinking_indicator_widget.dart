import 'package:flutter/material.dart';
import 'solid_indicator_widget.dart';

class BlinkingIndicatorWidget extends StatelessWidget {
  final Color _color;
  final double _size;
  final Duration _duration;
  final double _end;
  final EdgeInsets? _margin;
  final EdgeInsets? _padding;
  final double _innerFactor;

  const BlinkingIndicatorWidget({
    Key? key,
    required Color color,
    required double size,
    required Duration duration,
    double end = 0.0,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double innerFactor = SolidIndicatorWidget.INNER_FACTOR,
  })  : _color = color,
        _size = size,
        _duration = duration,
        _end = end,
        _margin = margin,
        _padding = padding,
        _innerFactor = innerFactor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlinkAnimation(
      duration: _duration,
      end: _end,
      child: SolidIndicatorWidget(
        size: _size,
        color: _color,
        margin: _margin,
        padding: _padding,
        innerFactor: _innerFactor,
      ),
    );
  }
}

class BlinkAnimation extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final double end;

  const BlinkAnimation({
    required this.duration,
    required this.child,
    this.end = 0.0,
  });

  @override
  _BlinkAnimationState createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 1.0, end: widget.end).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
