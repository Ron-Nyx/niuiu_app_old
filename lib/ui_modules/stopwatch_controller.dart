part of 'stopwatch.dart';

enum TimerState {
  IDLE,
  COUNTING,
  PAUSED,
}

class StopWatchController {
  final Duration _startTime;
  final Duration? _endTime;
  final Duration _intervalDuration;
  final bool _reversed;
  Timer? _timer;

  StreamController<Duration> _streamController = StreamController<Duration>.broadcast();

  Stream<Duration> get stream => _streamController.stream;

  Duration _elapsedDuration;

  Duration get elapsedDuration => _elapsedDuration;

  int get _elapsedMilliseconds => elapsedDuration.inMilliseconds;

  int get days => (_elapsedMilliseconds / 86400000).floor();

  int get hours => ((_elapsedMilliseconds / 3600000).floor() % 24);

  int get minutes => ((_elapsedMilliseconds / 60000).floor() % 60);

  int get seconds => ((_elapsedMilliseconds / 1000).floor() % 60);

  int get milliseconds => _elapsedMilliseconds % 1000;

  StopWatchController({
    Duration startTime = const Duration(seconds: 0),
    Duration? endTime,
    Duration intervalDuration = const Duration(seconds: 1),
  })
      : _startTime = startTime,
        _endTime = endTime,
        _intervalDuration = intervalDuration,
        _reversed = (endTime != null) && (startTime > endTime),
        _elapsedDuration = startTime;

  TimerState timerState = TimerState.IDLE;

  StopWatchController start() {
    if (timerState == TimerState.IDLE) {
      timerState = TimerState.COUNTING;

      _streamController.add(_elapsedDuration);

      _timer = Timer.periodic(
        _intervalDuration,
            (_) async {
          _increment(_intervalDuration * (_reversed ? -1 : 1));

          if (_endTime != null) {
            Duration durationLeft = (_endTime! - _elapsedDuration);
            // print(
            //     '_elapsedDuration: [$_elapsedDuration] durationLeft: [$durationLeft] _intervalDuration: [$_intervalDuration] durationLeft < _intervalDuration: ${durationLeft
            //         .abs() < _intervalDuration}');
            // print(' ');
            if (durationLeft.abs() < _intervalDuration) {
              Future.delayed(durationLeft.abs()).then((_) {
                _increment(durationLeft);
                stop();
              });
            }
          }
        },
      );
    }
    return this;
  }

  void _increment(Duration diff) {
    if (timerState == TimerState.COUNTING) {
      _elapsedDuration += diff;
      _streamController.add(_elapsedDuration);
    }
    // print('_increment by: [$diff] _elapsedDuration: [$_elapsedDuration]');
  }

  void stop() {
    if (timerState != TimerState.IDLE) {
      timerState = TimerState.IDLE;
      _timer?.cancel();
      _streamController.close();
    }
  }

  void pause() => timerState = TimerState.PAUSED;

  void resume() => timerState = TimerState.COUNTING;

  void reset() {
    timerState = TimerState.IDLE;
    _timer?.cancel();
    _elapsedDuration = _startTime;
    _streamController.add(_elapsedDuration);
  }

  StreamSubscription onDuration(Duration duration, Function() fn) =>
      stream.listen((_duration) {
        if (_duration == duration) {
          fn();
        }
      });

  StreamSubscription onDurationRange(Duration duration1, Duration duration2, Function() fn, {bool repeat = false}) {
    Duration smallDuration;
    Duration bigDuration;
    if (duration1 <= duration2) {
      smallDuration = duration1;
      bigDuration = duration2;
    } else {
      smallDuration = duration2;
      bigDuration = duration1;
    }

    bool passed = false;

    return stream.listen((_duration) {
      if (!repeat && passed) return;
      if (_duration >= smallDuration && _duration <= bigDuration) {
        passed = true;
        fn();
      }
    });
  }

  StreamSubscription onDurationPassed(Duration duration, Function() fn, {bool repeat = false}) =>
      _reversed
          ? onDurationRange(Duration.zero, duration, fn, repeat: repeat)
          : onDurationRange(Duration(days: 500000), duration, fn, repeat: repeat);

  StreamSubscription onStart(Function() fn) => onDurationPassed(_startTime, fn, repeat: false);

  Future<Duration> waitForDurationRange(Duration duration1, Duration duration2) async {
    Duration smallDuration;
    Duration bigDuration;
    if (duration1 <= duration2) {
      smallDuration = duration1;
      bigDuration = duration2;
    } else {
      smallDuration = duration2;
      bigDuration = duration1;
    }

    return stream.firstWhere((_duration) => (_duration >= smallDuration && _duration <= bigDuration));
  }

  Future<void> waitForDurationPassed(Duration duration) async =>
      _reversed
          ? waitForDurationRange(Duration.zero, duration)
          : waitForDurationRange(Duration(days: 500000), duration);

  Future<void> waitForStart() async => waitForDurationPassed(_startTime);

  Future<void> waitForEnd() async => (_endTime == null) ? null : waitForDurationPassed(_endTime!);
}
