library start_session_modal;

import 'package:flutter/material.dart' hide View;
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/ui_modules/flex_container.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/ui_modules/home_page/home_page_module.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/details_step/details_step_module.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/ready_step/ready_step_module.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/sensitivity_step/sensitivity_step_module.dart';
import 'package:niuiu_app/ui_modules/start_session_steps/signal_step/signal_step_module.dart';
import 'package:device_driver/device_driver.dart';
import 'package:ban_communication/ban_communication.dart';
import 'package:niuiu_app/ui_modules/start_session_loading/start_session_loading_module.dart';
import 'package:niuiu_app/service_modules/session_configurations.dart';

part 'start_session_modal_accessor.dart';
part 'start_session_modal_controller.dart';
part 'start_session_modal_view.dart';
part 'step.dart';
part 'gen/start_session_modal_module.gen.mvc_builder.dart';