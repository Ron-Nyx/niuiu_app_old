part of live_graph;

@view
class LiveGraph extends View<LiveGraphController> {
  LiveGraph._();

  @override
  Widget buildView(BuildContext context, LiveGraphController con, ViewDetails viewDetails) {
    return StateConsumer<GraphBooleans>(
      controller: con.displayGraphsStateController,
      builder: (context, show) {
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: (show.raw)
                  ? StateConsumer<GraphData>(
                      key: UniqueKey(),
                      controller: con.rawGraphDataStateController,
                      builder: (context, subview) => LineChart(
                        LineChartData(
                          clipData: const FlClipData.all(),
                          minY: LiveGraphController.MIN_Y.toDouble(),
                          maxY: LiveGraphController.MAX_Y.toDouble(),
                          minX: subview.spots.first.x,
                          maxX: subview.spots.last.x,
                          lineBarsData: [
                            LineChartBarData(
                              color: ThemeService.i.themeModel.textColor2,
                              spots: subview.spots,
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 1,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          lineTouchData: LineTouchData(enabled: false),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                        ),
                        duration: Duration.zero,
                      ),
                    )
                  : SizedBox(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: (show.thetaBandPass)
                  ? StateConsumer<GraphData>(
                      key: UniqueKey(),
                      controller: con.thetaBandPassGraphDataStateController,
                      builder: (context, subview) => LineChart(
                        LineChartData(
                          clipData: const FlClipData.all(),
                          minY: LiveGraphController.MIN_Y.toDouble(),
                          maxY: LiveGraphController.MAX_Y.toDouble(),
                          minX: subview.spots.first.x,
                          maxX: subview.spots.last.x,
                          lineBarsData: [
                            LineChartBarData(
                              color: Colors.green,
                              spots: subview.spots,
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 1,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          lineTouchData: LineTouchData(enabled: false),
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                        ),
                        duration: Duration.zero,
                      ),
                    )
                  : SizedBox(),
            ),
            StateConsumer<bool>(
              controller: con.displayGraduationsStateController,
              builder: (context, show) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: (show)
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(
                                  26,
                                  (i) {
                                    return Container(
                                      color: (i % 5 == 0) ? Colors.orangeAccent : Colors.white,
                                      width: (i % 5 == 0) ? 1 : 0.5,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
