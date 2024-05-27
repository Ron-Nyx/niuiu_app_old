library live_graph;

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart' hide View;
import 'package:mvc/mvc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:device_driver/device_driver.dart';
import 'package:iirjdart/butterworth.dart';

part 'graph_data.dart';
part 'live_graph_controller.dart';
part 'live_graph_view.dart';
part 'gen/live_graph_module.gen.mvc_builder.dart';