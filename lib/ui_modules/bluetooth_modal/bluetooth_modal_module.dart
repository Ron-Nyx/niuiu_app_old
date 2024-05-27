library bluetooth_modal;

import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart' hide View;
import 'package:flutter/services.dart';
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/ui_modules/flex_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:state_consumer/state_consumer.dart';
import 'package:device_driver/device_driver.dart';
import 'package:window_manager/window_manager.dart';
import 'package:process_handler/process.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:enums/enums.dart';

part 'bluetooth_modal_controller.dart';
part 'bluetooth_modal_view.dart';
part 'gen/bluetooth_modal_module.gen.mvc_builder.dart';