import 'package:aquaponia/Home/module_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhLevelDisplay extends StatelessWidget {
  const PhLevelDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/phlevel'),
      child: ModuleNavigation(
          title: 'pH Level', value: 7.5.toString(), icon: Icons.touch_app),
    );
  }
}
