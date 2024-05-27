part of sensitivity_step;

@view
class SensitivityStep extends View<SensitivityStepController> {
  SensitivityStep._();

  @override
  Widget buildView(BuildContext context, SensitivityStepController con, ViewDetails viewDetails) {
    return OverflowBox(
      maxHeight: 600,
      alignment: Alignment.topCenter,
      child: StateConsumer<StimulationPhase>(
        controller: con.stimulationPhaseStateController,
        builder: (context, stimulationPhase) {
          bool loading = [StimulationPhase.STARTING, StimulationPhase.ENDING].contains(stimulationPhase);
          bool sessionInProgress = stimulationPhase == StimulationPhase.IN_PROGRESS;
          bool isIdle = stimulationPhase == StimulationPhase.IDLE;
          return Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sensitivity threshold level',
                  style: TextStyle(
                    fontSize: 24,
                    color: ThemeService.i.themeModel.textColor2,
                  ),
                ),
                SizedBox(height: 62),
                Center(
                  child: StateConsumer<double>(
                    controller: con.progressStateController,
                    builder: (context, progress) {
                      return Column(
                        children: [
                          Container(
                            // width: 97,
                            height: 56,
                            child: Text(
                              '${progress.floor()}%',
                              style: TextStyle(
                                fontSize: 47,
                                fontWeight: FontWeight.w400,
                                color: ThemeService.i.themeModel.textColor2,
                              ),
                            ),
                          ),
                          SizedBox(height: 18.5),
                          Center(
                            child: Container(
                              width: 425,
                              height: 67.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 11.7,
                                    color: ThemeService.i.themeModel.primaryColor,
                                  ),
                                  Expanded(
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        double extraWidth = 1;
                                        double extraHeight = 1;
                                        return Stack(
                                          children: [
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTapDown: (details) {
                                                  progress = ((details.localPosition.dx / constraints.maxWidth) * 100).clamp(0, 100);
                                                  con.progressStateController.setState(progress);
                                                },
                                                onHorizontalDragUpdate: (details) {
                                                  progress = ((details.localPosition.dx / constraints.maxWidth) * 100).clamp(0, 100);
                                                  con.progressStateController.setState(progress);
                                                },
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [
                                                            ThemeService.i.themeModel.gray1,
                                                            ThemeService.i.themeModel.primaryColor,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: -extraWidth,
                                                      child: Container(
                                                        width: constraints.maxWidth * (1 - progress / 100) + extraWidth,
                                                        height: constraints.maxHeight + extraHeight,
                                                        decoration: BoxDecoration(
                                                          color: ThemeService.i.themeModel.gray1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (!isIdle)
                                              MouseRegion(
                                                child: SizedBox.expand(),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 33.5),
                Center(
                  child: Container(
                    width: 155,
                    height: 47,
                    child: MaterialButton(
                      onPressed: loading ? null : (sessionInProgress ? con._onStopButtonPressed : con._onTestSensitivityButtonPressed),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ThemeService.i.themeModel.primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textColor: ThemeService.i.themeModel.textColor2,
                      child: Center(
                        child: loading
                            ? SpinKitCircle(
                                color: ThemeService.i.themeModel.textColor2,
                                size: 25,
                              )
                            : Text(
                                sessionInProgress ? 'Stop' : 'Test Sensitivity',
                                style: TextStyle(fontSize: 14),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 65),
                Container(
                  width: 540,
                  child: Text(
                    'The patient will undergo escalating stimulation to evaluate sensitivity, and should be informed about potential tingling. Be prepared to halt the process if discomfort is reported.',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeService.i.themeModel.textColor2,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
