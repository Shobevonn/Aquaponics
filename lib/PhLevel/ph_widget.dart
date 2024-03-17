import 'package:aquaponia/Home/Bar%20Chart/bar_chart.dart';
import 'package:aquaponia/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhWidget extends GetView<HomeController> {
  const PhWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.touch_app),
                          Text(
                              'PH Level ${controller.phLevelController.latestPhLevel!.value!.value}',
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 28,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 40, 62, 2),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: MaterialButton(
                        onPressed: () => Get.toNamed('/phlevel'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Show ph record',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'Poppins'),
                            ),
                            Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: SizedBox(
                width: Get.width,
                child: const Text(
                  'The pH level is a measure of how acidic or basic (alkaline) a water is. It is measured on a scale from 0 to 14.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Container(
                        height: 25,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ]),
                        child: Container(
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Acidic 1 - 6',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Container(
                        height: 25,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ]),
                        child: Container(
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 49, 165, 73),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Neutral 7',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Container(
                        height: 25,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ]),
                        child: Container(
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 68, 43, 127),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Alkaline 8 - 14',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              width: Get.width,
              height: 180,
              child: const Padding(
                padding: EdgeInsets.only(right: 8.0, top: 12.0),
                child: BarChart(),
              ),
            )
          ],
        ));
  }
}
