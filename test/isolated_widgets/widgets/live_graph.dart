import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/flutter_bluetooth.dart';
import 'package:device_driver/device_driver.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/ui_modules/live_graph/live_graph_module.dart';

Future<Device> deviceFuture = () async {
  Device device = Device(
      id: 'test',
      bluetooth: DA14531Module(
          bleDevice: BLEDevice(
        address: 'test',
      )));
  await device.init();
  return device;
}();

Widget liveGraph = FutureBuilder<Device>(
  future: deviceFuture,
  builder: (BuildContext context, AsyncSnapshot snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return Container();
    } else {
      Device device = snap.data;
      return Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: ThemeService.i.themeModel.gray2,
              border: Border.all(
                color: ThemeService.i.themeModel.primaryColor,
                width: 1,
              ),
            ),
            child: $LiveGraph(
              device: device,
              dataLength: 250,
            ),
          ),
        ),
      );
    }
  },
);
