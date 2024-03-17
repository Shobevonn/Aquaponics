import 'package:get/get.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothController extends GetxController {
  bool isBluetoothConnected = false;
  List<BluetoothDevice> devices = [];
  BluetoothConnection? connection;
  FlutterBluetoothSerial? discovery;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);

      isBluetoothConnected = true;
    } catch (error) {
      print('Error: $error');
    } finally {
      connection!.close();
      print('Disconnected from the device');
    }
  }

  void startDiscovery() {
    discovery?.startDiscovery().listen((device) {
      devices.add(device.device);
    });
  }
}
