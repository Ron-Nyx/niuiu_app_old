part of live_graph;

class GraphData {
  final List<double> y;
  final List<FlSpot> spots;

  GraphData({
    required this.y,
  }) : spots = List.generate(y.length, (i) => i)
            .map((i) => FlSpot(
                  i.toDouble(),
                  y[i],
                ))
            .toList();

  const GraphData.empty()
      : y = const [],
        spots = const [];

  GraphData.zeros(int length)
      : y = List.filled(length, 0.0, growable: true),
        spots = List.generate(length, (i) => i)
            .map((i) => FlSpot(
                  i.toDouble(),
                  0.0,
                ))
            .toList();

  bool get isAllZeros {
    for (FlSpot spot in spots) {
      if (spot.y != 0) return false;
    }
    return true;
  }

  // factory GraphData.zeros(int length) => GraphData(y: List.filled(length, 0.0));

  // GraphData pushValues(List<double> newYValues) {
  //   List<FlSpot> newSpots = List.generate(newYValues.length, (i) => i)
  //       .map((i) => FlSpot(
  //             (spots.length - newYValues.length + i).toDouble(),
  //             newYValues[i],
  //           ))
  //       .toList();
  //   spots.removeRange(0, newYValues.length);
  //   spots.addAll(newSpots);
  //   return this;
  // }

  GraphData pushValues(List<double> newYValues) {
    y
      ..removeRange(0, newYValues.length)
      ..addAll(newYValues);
    return GraphData(y: y);
  }

// GraphData.prepared({
//   required this.x,
//   required this.y,
//   required this.spots,
// });
//
// /// Returns a new GraphData instance with the same property instances
// /// This is so the state controller will recognize a change has occured,
// GraphData copyToNewInstance() => GraphData.prepared(x: x, y: y, spots: spots);
//
// GraphData _copyAndAddSpots(List<FlSpot> newSpots) {
//   List<FlSpot> newSpotList = List.from(spots);
//   newSpotList.addAll(newSpots);
//   return GraphData.prepared(x: x, y: y, spots: newSpotList);
// }
//
// GraphData _copyAndAddYValues(List<double> newYValues) {
//   List<double> newYList = List.from(y);
//   newYList.addAll(newYValues);
//   return GraphData.prepared(x: x, y: newYList, spots: spots);
// }
}
