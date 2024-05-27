library welcome_page;

import 'dart:io';
import 'package:flutter/material.dart' hide View;
import 'package:path_provider/path_provider.dart';
import 'package:mvc/mvc.dart';
import 'package:niuiu_app/service_modules/screen/screen.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/service_modules/navigation/navigation.dart' hide View;
import 'package:niuiu_app/ui_modules/bluetooth_modal/bluetooth_modal_module.dart';

part 'welcome_page_controller.dart';
part 'welcome_page_view.dart';
part 'gen/welcome_page_module.gen.mvc_builder.dart';