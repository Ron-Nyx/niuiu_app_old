part of head_figure_right;

@view
class HeadFigureRight extends View<HeadFigureRightController> {
  HeadFigureRight._();

  @override
  Widget buildView(BuildContext context, HeadFigureRightController con, ViewDetails viewDetails) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 18),
                child: SvgPicture.asset(
                  'assets/svgs/head_figure_right.svg',
                ),
              ),
              ...List.generate(
                3,
                (i) {
                  return StateConsumer<SignalStatus>(
                    controller: $SignalStep.getControllerWhere((_) => true).signalStatusController,
                    builder: (context, signalStatus) {
                      EdgeInsets margin = {
                        0: EdgeInsets.only(top: 48, left: 30),
                        1: EdgeInsets.only(top: 54, left: 78.5),
                        2: EdgeInsets.only(top: 65, left: 110.5),
                      }[i]!;
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        child: <SignalStatus, Widget>{
                          SignalStatus.IDLE: SolidIndicatorWidget(
                            key: UniqueKey(),
                            color: Colors.grey,
                            size: 15,
                            margin: margin,
                          ),
                          SignalStatus.BAD: SolidIndicatorWidget(
                            key: UniqueKey(),
                            color: Color(0xFFFE6C6C),
                            size: 15,
                            margin: margin,
                          ),
                          SignalStatus.STABILIZING: BlinkingIndicatorWidget(
                            key: UniqueKey(),
                            duration: Duration(milliseconds: 1200),
                            end: 0.5,
                            color: Color(0xFF3ED598),
                            size: 15,
                            margin: margin,                            // margin: margin,
                          ),
                          SignalStatus.STABLE: SolidIndicatorWidget(
                            key: UniqueKey(),
                            color: Color(0xFF3ED598),
                            size: 15,
                            margin: margin,
                          ),
                        }[signalStatus]!,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
