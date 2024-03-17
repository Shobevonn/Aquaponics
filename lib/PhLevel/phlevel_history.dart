import 'package:aquaponia/Home/home_controller.dart';
import 'package:aquaponia/PhLevel/Model/Phlevel_model.dart';
import 'package:aquaponia/Util/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhLevelHistory extends GetView<HomeController> {
  const PhLevelHistory({Key? key}) : super(key: key);

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
                            controller.phLevelController.phlevelFilter.value =
                                1;
                            controller.phLevelController.fetchdaysRecords();
                          },
                          child: Obx(() => Text(
                                'All',
                                style: TextStyle(
                                    color: controller.phLevelController
                                                .phlevelFilter.value ==
                                            1
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.phLevelController.phlevelFilter.value =
                                2;
                            controller.phLevelController.fetchdaysRecords();
                          },
                          child: Obx(() => Text(
                                '30 days',
                                style: TextStyle(
                                    color: controller.phLevelController
                                                .phlevelFilter.value ==
                                            2
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.phLevelController.phlevelFilter.value =
                                3;
                            controller.phLevelController.fetchdaysRecords();
                          },
                          child: Obx(() => Text(
                                '7 days',
                                style: TextStyle(
                                    color: controller.phLevelController
                                                .phlevelFilter.value ==
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
                    Text('PH Level',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 80,
                      child: Text('Status',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text('Date',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller
                                .phLevelController.phLevels.value!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (controller
                                  .phLevelController.phLevels.value!.isEmpty) {
                                return SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: const Center(
                                    child: Text('NO RECORD FOUND.',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              }
                              PhLevel model = controller
                                  .phLevelController.phLevels.value![index];
                              return Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.black12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                            '${model.value!.toString()} pH',
                                            style:
                                                const TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                            model.value! < 7
                                                ? 'Acidic'
                                                : model.value! > 7
                                                    ? 'Alkaline'
                                                    : 'Neutral',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: model.value! < 7
                                                    ? Colors.deepOrange
                                                    : model.value! > 7
                                                        ? Colors.purple
                                                        : Colors.green,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                          DateFormat.withValue(model.date!)
                                              .dateTodayShort(),
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )))
          ],
        ));
  }
}
