library signal_step;

import 'dart:typed_data';
import 'package:ban_communication/ban_communication.dart';
import 'package:device_driver/device_driver.dart';
import 'package:flutter/material.dart' hide View;
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/service_modules/ban_communication/ban_communication.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/ui_modules/start_session_modal/start_session_modal_module.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/signal_step/head_figure_left/head_figure_left_module.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/signal_step/head_figure_right/head_figure_right_module.dart';
import 'package:enums/enums.dart';
import 'package:niuiu_app/ui_modules/flex_container.dart';
import 'package:niuiu_app/ui_modules/live_graph/live_graph_module.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:niuiu_app/service_modules/session_configurations.dart';
import 'package:device_driver/device_driver.dart';

part 'signal_step_controller.dart';
part 'signal_step_view.dart';
part 'gen/signal_step_module.gen.mvc_builder.dart';