import 'dart:async';
import 'package:flutter/material.dart';

part 'stopwatch_controller.dart';
part 'stopwatch_time_unit.dart';

class StopWatch extends StatelessWidget {
  final StopWatchController _controller;
  final List<StopWatchTimeUnit> _countdownTimeUnits;
  final int _defaultLeadingDigits;
  final TextStyle? _textStyle;

  StopWatch({
    required StopWatchController controller,
    StopWatchTimeUnit fromUnit = StopWatchTimeUnit.DAYS,
    StopWatchTimeUnit toUnit = StopWatchTimeUnit.MILLISECONDS,
    int defaultLeadingDigits = 1,
    TextStyle? textStyle,
  })  : _controller = controller,
        _countdownTimeUnits = _getStopWatchTimeUnits(fromUnit, toUnit),
        _defaultLeadingDigits = defaultLeadingDigits,
        _textStyle = textStyle;

  static List<StopWatchTimeUnit> _getStopWatchTimeUnits(StopWatchTimeUnit fromUnit, StopWatchTimeUnit toUnit) {
    int fromIndex = StopWatchTimeUnit.values.indexOf(fromUnit);
    int toIndex = StopWatchTimeUnit.values.indexOf(toUnit);
    assert(fromIndex <= toIndex, 'fromIndex > toIndex');
    return StopWatchTimeUnit.values.sublist(fromIndex, toIndex + 1);
  }

  bool _isStopWatchTimeUnitIncluded(StopWatchTimeUnit countdownTimeUnit) => _countdownTimeUnits.contains(countdownTimeUnit);

  @override
  Widget build(BuildContext context) {
    bool daysIncluded = _isStopWatchTimeUnitIncluded(StopWatchTimeUnit.DAYS);
    bool hoursIncluded = _isStopWatchTimeUnitIncluded(StopWatchTimeUnit.HOURS);
    bool minutesIncluded = _isStopWatchTimeUnitIncluded(StopWatchTimeUnit.MINUTES);
    bool secondsIncluded = _isStopWatchTimeUnitIncluded(StopWatchTimeUnit.SECONDS);
    bool millisecondsIncluded = _isStopWatchTimeUnitIncluded(StopWatchTimeUnit.MILLISECONDS);
    return StreamBuilder<Duration>(
        stream: _controller.stream,
        initialData: _controller._elapsedDuration,
        builder: (context, snapshot) {
          int millisecondsLeft = snapshot.data!.inMilliseconds;

          Map<StopWatchTimeUnit, int?> timeValues = {};
          timeValues[StopWatchTimeUnit.DAYS] = daysIncluded ? (millisecondsLeft / 86400000).floor() : null;
          timeValues[StopWatchTimeUnit.HOURS] = hoursIncluded ? ((millisecondsLeft / 3600000).floor() % 24) : null;
          timeValues[StopWatchTimeUnit.MINUTES] = minutesIncluded ? ((millisecondsLeft / 60000).floor() % 60) : null;
          timeValues[StopWatchTimeUnit.SECONDS] = secondsIncluded ? ((millisecondsLeft / 1000).floor() % 60) : null;
          timeValues[StopWatchTimeUnit.MILLISECONDS] = millisecondsIncluded ? (millisecondsLeft % 1000) : null;

          Map<StopWatchTimeUnit, int?> timeDigits = {};
          timeDigits[StopWatchTimeUnit.DAYS] = daysIncluded ? _defaultLeadingDigits : null;
          timeDigits[StopWatchTimeUnit.HOURS] = hoursIncluded ? (daysIncluded ? 2 : _defaultLeadingDigits) : null;
          timeDigits[StopWatchTimeUnit.MINUTES] = minutesIncluded ? (hoursIncluded ? 2 : _defaultLeadingDigits) : null;
          timeDigits[StopWatchTimeUnit.SECONDS] = secondsIncluded ? (minutesIncluded ? 2 : _defaultLeadingDigits) : null;
          timeDigits[StopWatchTimeUnit.MILLISECONDS] = millisecondsIncluded ? (secondsIncluded ? 3 : _defaultLeadingDigits) : null;

          Map<StopWatchTimeUnit, String?> timeValueStrings = {};

          for (StopWatchTimeUnit timeUnit in StopWatchTimeUnit.values) {
            String? str;
            if (timeValues[timeUnit] != null) {
              str = '${timeValues[timeUnit]}';
              int digits = str.length;
              int digitsDiff = timeDigits[timeUnit]! - digits;
              if (digitsDiff > 0) str = '${'0' * digitsDiff}$str';
            }
            timeValueStrings[timeUnit] = str;
          }
          return Text(
            timeValueStrings.values.where((s) => s != null).join(' : '),
            style: _textStyle,
          );
        });
  }
}
