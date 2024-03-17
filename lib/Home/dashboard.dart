import 'package:aquaponia/Feeder/feeder_display.dart';
import 'package:aquaponia/Home/applogo.dart';
import 'package:aquaponia/PhLevel/ph_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 62, 2),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 50,
              child: AppLogo(),
            ),
            const SizedBox(height: 20),
            Expanded(
                flex: 2,
                child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                width: Get.width,
                                height: 200,
                                child: const PhWidget())),
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FeederDisplay(),
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
