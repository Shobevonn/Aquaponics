import 'package:flutter/material.dart';
import 'package:aquaponia/Home/Bluetooth/bluetooth_controller.dart';
import 'package:get/get.dart';

class BluetoothView extends GetView<BluetoothController> {
  const BluetoothView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.devices.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.devices[index].name ?? 'NONE'),
          subtitle: Text(controller.devices[index].address),
          onTap: () {
            // Handle device selection
            controller.connectToDevice(controller.devices[index]);
          },
        );
      },
    );
  }
}
