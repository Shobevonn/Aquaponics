import 'package:aquaponia/Home/module_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/temperature'),
      child: ModuleNavigation(
          title: "Temperature",
          value: '${45.toString()} C\u00B0',
          icon: Icons.thermostat),
    );
  }
}
