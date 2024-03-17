// import 'dart:math';

// import 'package:aquaponia/Database/database.dart';
import 'package:aquaponia/Feeder/Controller/feeder_controller.dart';
import 'package:aquaponia/PhLevel/Controller/phlevel_controller.dart';
import 'package:aquaponia/Temperature/Controller/temperature_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final PhLevelController phLevelController = Get.put(PhLevelController());
  final FeederController feederController = Get.put(FeederController());
  final TemperatureController temperatureController =
      Get.put(TemperatureController());

  // Random random = Random();

  // void initializeDatabases() async {
  //   int result = await DatabaseConfig().insertData({
  //     'create_at': DateTime.now().toIso8601String(),
  //     'temperature_value': random.nextInt(40) + 1,
  //   }, 'temperature');

  //   print('Inserted Temperature record ID: $result');

  //   result = await DatabaseConfig().insertData({
  //     'create_at': DateTime.now().toIso8601String(),
  //     'ph_level_value': random.nextInt(14) + 1,
  //   }, 'phlevel');

  //   print('Inserted PH Level record ID: $result');

  //   result = await DatabaseConfig().insertData({
  //     'time': '08:00:00',
  //     'week_days': 1,
  //     'week_ends': 1,
  //     'entire_week': 1,
  //     'effective_at': DateTime.now().toIso8601String(),
  //     'end_date': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
  //   }, DatabaseConfig.feederTable);

  //   print('Inserted record ID: $result');
  // }
}
