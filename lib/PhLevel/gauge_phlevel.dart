import 'package:aquaponia/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugePhLevel extends GetView<HomeController> {
  const GaugePhLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: Obx(
          () => SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 14, ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 1, color: Colors.red),
              GaugeRange(startValue: 1, endValue: 2, color: Colors.deepOrange),
              GaugeRange(startValue: 2, endValue: 3, color: Colors.orange),
              GaugeRange(startValue: 3, endValue: 4, color: Colors.yellow),
              GaugeRange(
                  startValue: 4,
                  endValue: 5,
                  color: const Color.fromARGB(255, 175, 204, 49)),
              GaugeRange(
                  startValue: 5,
                  endValue: 6,
                  color: const Color.fromARGB(255, 128, 189, 63)),
              GaugeRange(
                  startValue: 5,
                  endValue: 6,
                  color: const Color.fromARGB(255, 75, 177, 71)),
              GaugeRange(
                  startValue: 6,
                  endValue: 7,
                  color: const Color.fromARGB(255, 49, 165, 73)),
              GaugeRange(
                  startValue: 7,
                  endValue: 8,
                  color: const Color.fromARGB(255, 33, 174, 104)),
              GaugeRange(
                  startValue: 8,
                  endValue: 9,
                  color: const Color.fromARGB(255, 10, 178, 176)),
              GaugeRange(
                  startValue: 9,
                  endValue: 10,
                  color: const Color.fromARGB(255, 68, 139, 199)),
              GaugeRange(
                  startValue: 10,
                  endValue: 11,
                  color: const Color.fromARGB(255, 54, 80, 159)),
              GaugeRange(
                  startValue: 11,
                  endValue: 12,
                  color: const Color.fromARGB(255, 87, 78, 157)),
              GaugeRange(
                  startValue: 12,
                  endValue: 13,
                  color: const Color.fromARGB(255, 96, 57, 152)),
              GaugeRange(
                  startValue: 13,
                  endValue: 15,
                  color: const Color.fromARGB(255, 68, 43, 127)),
            ], pointers: <GaugePointer>[
              NeedlePointer(
                  value: double.parse(controller
                      .phLevelController.latestPhLevel!.value!.value
                      .toString()))
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: SizedBox(
                      child: Obx(
                    () => Text(
                        '${controller.phLevelController.latestPhLevel?.value?.value.toString() ?? 2.toString()} pH',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  )),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ]),
        ));
  }
}
