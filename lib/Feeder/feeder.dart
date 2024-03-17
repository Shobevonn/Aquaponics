import 'package:aquaponia/Feeder/feeder_history.dart';
import 'package:aquaponia/Feeder/feeder_widget.dart';
import 'package:aquaponia/Home/home_controller.dart';
import 'package:aquaponia/component/return_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Feeder extends GetView<HomeController> {
  const Feeder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rxn<Color> main = Rxn<Color>(const Color.fromARGB(255, 40, 62, 2)).obs();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 40, 62, 2),
            toolbarHeight: 0,
            elevation: 0),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 40, 62, 2),
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                isDismissible: false,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Set feeding schedule'),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: SizedBox(
                              width: Get.width,
                              height: 60,
                              child: TextField(
                                controller:
                                    controller.feederController.timeData,
                                decoration: const InputDecoration(
                                    icon:
                                        Icon(Icons.timer), //icon of text field
                                    labelText:
                                        "Enter Time" //label text of field
                                    ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    initialTime: TimeOfDay.now(),
                                    context: context,
                                  );

                                  if (pickedTime != null) {
                                    DateTime parsedTime = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        pickedTime.hour,
                                        pickedTime.minute);

                                    String formattedTime = DateFormat('hh:mm a')
                                        .format(parsedTime);

                                    controller.feederController.timeData.text =
                                        formattedTime;
                                  } else {
                                    print("Time is not selected");
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                MaterialButton(
                                  color: main.value,
                                  onPressed: () {
                                    bool status = controller.feederController
                                        .registerSchedule();
                                    if (status) {
                                      Navigator.pop(context);
                                    } else {
                                      main.value = Colors.red;
                                    }
                                  },
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          label: const Text('New Schedule',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
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
                                  child: FeederWidget())),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: FeederHistory(),
                              ))
                        ],
                      ),
                    ))
              ],
            )));
  }
}
