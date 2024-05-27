part of signal_step;

@view
class SignalStep extends View<SignalStepController> {
  SignalStep._();

  @override
  Widget buildView(BuildContext context, SignalStepController con, ViewDetails viewDetails) {
    return OverflowBox(
      maxHeight: 600,
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Signal Session',
              style: TextStyle(
                fontSize: 24,
                color: ThemeService.i.themeModel.textColor2,
              ),
            ),
            SizedBox(height: 58),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 188,
                          height: 219,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ThemeService.i.themeModel.gray3,
                              width: 1,
                            ),
                          ),
                          child: $HeadFigureLeft(),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Left',
                          style: TextStyle(
                            fontSize: 12,
                            color: ThemeService.i.themeModel.textColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 188,
                          height: 219,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ThemeService.i.themeModel.gray3,
                              width: 1,
                            ),
                          ),
                          child: $HeadFigureRight(),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Right',
                          style: TextStyle(
                            fontSize: 12,
                            color: ThemeService.i.themeModel.textColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 280,
                          height: 219,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ThemeService.i.themeModel.gray3,
                              width: 1,
                            ),
                          ),
                          child: $LiveGraph.fromController(con.liveGraphController),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Live Data',
                          style: TextStyle(
                            fontSize: 12,
                            color: ThemeService.i.themeModel.textColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 57),
            Container(
              width: 490,
              child: Text(
                'Keep Steady Contact Until All Lights are Green for 3 Seconds,\nand the \'Next\' Button Turns Blue',
                style: TextStyle(
                  fontSize: 16,
                  color: ThemeService.i.themeModel.textColor2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
