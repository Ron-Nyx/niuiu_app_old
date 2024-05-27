library home_page;

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:device_driver/device_driver.dart';
import 'package:flutter/material.dart' hide View;
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:recase/recase.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/ui_modules/start_session_modal/start_session_modal_module.dart';
import 'package:niuiu_app/ui_modules/live_graph/live_graph_module.dart';
import 'package:niuiu_app/ui_modules/stopwatch.dart';
import 'package:ban_communication/ban_communication.dart';
import 'package:enums/enums.dart';
import 'package:niuiu_app/service_modules/session_configurations.dart';
import 'package:niuiu_app/ui_modules/solid_indicator_widget.dart';
import 'package:niuiu_app/ui_modules/blinking_indicator_widget.dart';
import 'package:type_converter/type_converter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:niuiu_app/ui_modules/animated_switch.dart';
import 'package:niuiu_app/ui_modules/disconnection_modal.dart';
import 'package:niuiu_app/ui_modules/exit_app_modal.dart';

part 'home_page_accessor.dart';
part 'home_page_controller.dart';
part 'home_page_view.dart';
part 'gen/home_page_module.gen.mvc_builder.dart';