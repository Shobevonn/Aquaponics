import 'package:aquaponia/Home/home_controller.dart';
import 'package:aquaponia/Temperature/Model/temperature_model.dart';
import 'package:aquaponia/Util/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemperatureHistory extends GetView<HomeController> {
  const TemperatureHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filters',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.temperatureController.temperatureFilter
                                .value = 1;
                            controller.temperatureController.fetchRecords();
                          },
                          child: Obx(() => Text(
                                'All',
                                style: TextStyle(
                                    color: controller.temperatureController
                                                .temperatureFilter.value ==
                                            1
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.temperatureController.temperatureFilter
                                .value = 2;
                            controller.temperatureController.fetchdaysRecords();
                          },
                          child: Obx(() => Text(
                                '30 days',
                                style: TextStyle(
                                    color: controller.temperatureController
                                                .temperatureFilter.value ==
                                            2
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.temperatureController.temperatureFilter
                                .value = 3;
                            controller.temperatureController.fetchdaysRecords();
                          },
                          child: Obx(() => Text(
                                '7 days',
                                style: TextStyle(
                                    color: controller.temperatureController
                                                .temperatureFilter.value ==
                                            3
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: Get.width,
                height: 40,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Status',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    Text('Temperature',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    Text('Date',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Obx(
                    () => ListView.builder(
                        itemCount: controller
                            .temperatureController.temperatures.value!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (controller.temperatureController.temperatures
                              .value!.isEmpty) {
                            return SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: const Center(
                                child: Text('NO RECORD YET',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            );
                          }

                          Temperature model = controller
                              .temperatureController.temperatures.value![index];

                          return Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.white
                                    : Colors.grey),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 80,
                                      child: Text(model.condition(),
                                          style:
                                              const TextStyle(fontSize: 15))),
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                          '${model.value.toString()} C\u00B0',
                                          style: const TextStyle(fontSize: 15)),
                                    ),
                                  ),
                                  Text(
                                      DateFormat.withValue(model.date!)
                                          .dateTodayShort(),
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          );
                        }),
                  )),
            ))
          ],
        ));
  }
}
