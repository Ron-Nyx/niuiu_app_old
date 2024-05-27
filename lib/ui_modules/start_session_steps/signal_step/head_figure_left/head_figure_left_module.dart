library head_figure_left;

import 'dart:math';
import 'package:flutter/material.dart' hide View;
import 'package:process_handler/process.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:mvc/mvc.dart';
import 'package:recase/recase.dart';
import 'package:enums/gain.dart';
import 'package:enums/enums.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/signal_step/signal_step_module.dart';

import 'package:niuiu_app/ui_modules/blinking_indicator_widget.dart';
import 'package:niuiu_app/ui_modules/solid_indicator_widget.dart';
import 'package:device_driver/device_driver.dart';

part 'head_figure_left_controller.dart';
part 'head_figure_left_view.dart';
part 'gen/head_figure_left_module.gen.mvc_builder.dart';