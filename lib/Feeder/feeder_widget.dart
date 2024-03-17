import 'package:aquaponia/Database/database.dart';
import 'package:aquaponia/Feeder/Model/feeder_model.dart';
import 'package:aquaponia/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeederWidget extends GetView<HomeController> {
  const FeederWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Feeding Day Schedule',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87)),
                  Container()
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Obx(
                () => ListView.builder(
                    itemCount: controller
                        .feederController.currentFeederSchedules.value!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (controller.feederController.currentFeederSchedules
                          .value!.isEmpty) {
                        return SizedBox(
                          width: Get.height,
                          height: Get.height,
                          child: const Center(
                            child: Text('No schedule yet.'),
                          ),
                        );
                      }

                      FeederModel model = controller.feederController
                          .currentFeederSchedules.value![index];

                      return Dismissible(
                        key: Key(model.id.toString()),
                        onDismissed: (direction) async {
                          await DatabaseConfig()
                              .deleteFeederSchedule(model.id!);

                          controller.feederController.fetchLatestSchedules();
                        },
                        background: Container(
                          color: Colors.deepOrange,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(model.time!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 35,
                                child: Obx(
                                  () => FittedBox(
                                    fit: BoxFit.contain,
                                    child: Switch(
                                      value: model.status!.value,
                                      activeColor: Colors.blue,
                                      onChanged: (bool value) {
                                        model.status!.value =
                                            !model.status!.value;
                                        model.status!.refresh();

                                        DatabaseConfig().updateFeederStatus(
                                            model.id!, model.status!.value);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ))
          ],
        ));
  }
}
