part of start_session_modal;

enum Step {
  DETAILS,
  SIGNAL,
  SENSITIVITY,
  READY,
}

extension StepExtension on Step {
  int get index => Step.values.indexOf(this);

  bool get isFirst => index == 0;

  bool get isLast => index == Step.values.length - 1;

  Step? get previous {
    int index = this.index;
    return (index == 0) ? null : Step.values[index - 1];
  }

  Step? get next {
    int index = this.index;
    return (index == Step.values.length - 1) ? null : Step.values[index + 1];
  }

  bool operator > (Step step) => index > step.index;
  bool operator >= (Step step) => index >= step.index;
  bool operator < (Step step) => index < step.index;
  bool operator <= (Step step) => index <= step.index;
}
