import 'package:aquaponia/Temperature/gauge_temperature.dart';
import 'package:aquaponia/Temperature/temperature_history.dart';
import 'package:aquaponia/component/return_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 40, 62, 2),
          toolbarHeight: 0,
          elevation: 0),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const Positioned(top: 10, left: 10, child: ReturnWithLogo()),
              Positioned(
                  top: 65,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: const Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: GaugeTemperature())),
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: TemperatureHistory()))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
