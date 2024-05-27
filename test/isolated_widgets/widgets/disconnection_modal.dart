import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/flutter_bluetooth.dart';
import 'package:device_driver/device_driver.dart';
import 'package:niuiu_app/service_modules/theme/theme.dart';
import 'package:niuiu_app/ui_modules/disconnection_modal.dart';

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

Widget disconnectionModal = FutureBuilder<Device>(
  future: deviceFuture,
  builder: (BuildContext context, AsyncSnapshot snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return Container();
    } else {
      Device device = snap.data;
      return DisconnectionModal(
        device: device,
      );
    }
  },
);
