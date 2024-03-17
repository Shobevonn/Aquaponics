import 'package:aquaponia/Feeder/Model/feeder_model.dart';
import 'package:aquaponia/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeederDisplay extends GetView<HomeController> {
  const FeederDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 180,
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_rounded,
                                color: Color(0xFF515151), size: 20),
                            SizedBox(width: 5),
                            Text('Feeder Schedule',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(
                        width: 85,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Color(0xFF283E02),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: MaterialButton(
                          onPressed: () => Get.toNamed('/feeder'),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Show',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(controller.feederController.nearAlarm(),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF515151),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Obx(
                        () => Text(
                            'Alarm in ${controller.feederController.timeDuration.value}',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF515151),
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                height: 90,
                child: ListView.builder(
                    itemCount: controller
                        .feederController.currentFeederSchedules.value!.length,
                    itemBuilder: (context, int index) {
                      if (controller.feederController.currentFeederSchedules
                          .value!.isEmpty) {
                        return const SizedBox(
                            width: 100,
                            height: 100,
                            child: Text('NO RECORD',
                                style: TextStyle(color: Colors.grey)));
                      }

                      FeederModel modal = controller.feederController
                          .currentFeederSchedules.value![index];

                      if (modal.status!.value == false) return const SizedBox();

                      return SizedBox(
                        width: Get.width,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(modal.time!,
                                style: const TextStyle(
                                    color: Color(0xFF515151),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins')),
                            Text(
                                controller.feederController
                                    .parseStringTimeDifference(modal.time!),
                                style: const TextStyle(
                                    color: Color(0xFF515151),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'))
                          ],
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
