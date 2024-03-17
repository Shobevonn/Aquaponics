import 'package:aquaponia/Feeder/Model/feeder_model.dart';
import 'package:aquaponia/Home/home_controller.dart';
import 'package:aquaponia/Util/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeederHistory extends GetView<HomeController> {
  const FeederHistory({Key? key}) : super(key: key);

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
                            controller.feederController.historyFilter.value = 1;
                            controller.feederController.fetchFeederRecords();
                          },
                          child: Obx(() => Text(
                                'All',
                                style: TextStyle(
                                    color: controller.feederController
                                                .historyFilter.value ==
                                            1
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.feederController.historyFilter.value = 2;
                            controller.feederController
                                .fetchFeederdaysRecords();
                          },
                          child: Obx(() => Text(
                                '30 days',
                                style: TextStyle(
                                    color: controller.feederController
                                                .historyFilter.value ==
                                            2
                                        ? Colors.blue
                                        : Colors.black),
                              ))),
                      MaterialButton(
                          minWidth: 60,
                          onPressed: () {
                            controller.feederController.historyFilter.value = 3;
                            controller.feederController
                                .fetchFeederdaysRecords();
                          },
                          child: Obx(() => Text(
                                '7 days',
                                style: TextStyle(
                                    color: controller.feederController
                                                .historyFilter.value ==
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ID',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 80,
                        child: Text('Time',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      Text('Date',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Obx(
                      () => ListView.builder(
                          itemCount: controller
                              .feederController.historyFeed.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (controller
                                .feederController.historyFeed.value!.isEmpty) {
                              return Container();
                            }
                            FeederModel model = controller
                                .feederController.historyFeed.value![index];

                            return Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.black12),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(model.id.toString(),
                                        style: const TextStyle(fontSize: 15)),
                                    Text(model.time!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        DateFormat.withValue(model.date!)
                                            .dateTodayShort(),
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )))
          ],
        ));
  }
}
