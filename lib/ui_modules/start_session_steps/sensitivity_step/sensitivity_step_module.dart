library sensitivity_step;

import 'dart:math';
import 'package:device_driver/device_driver.dart';
import 'package:flutter/material.dart' hide View;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/ui_modules/start_session_modal/start_session_modal_module.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:niuiu_app/ui_modules/home_page/home_page_module.dart';
import 'package:niuiu_app/service_modules/session_configurations.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:enums/enums.dart';

part 'sensitivity_step_controller.dart';
part 'sensitivity_step_view.dart';
part 'gen/sensitivity_step_module.gen.mvc_builder.dart';