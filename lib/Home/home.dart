import 'package:aquaponia/Home/applogo.dart';
import 'package:aquaponia/Home/detailts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final List<Map<String, dynamic>> marketingData = [
  {
    'title': 'Precision Temperature Control',
    'description':
        'Ensure your aquatic ecosystem thrives in the perfect climate, tailored to your fish and plants` unique needs.',
    'icon': Icons.thermostat,
  },
  {
    'title': 'pH Harmony at Your Fingertips',
    'description':
        'Maintain the ideal water balance effortlessly, creating the optimal environment for your aquatic companions to flourish.',
    'icon': Icons.touch_app, // Assuming you have imported the Icons class
  },
  {
    'title': 'Automate Feeding for Peak Health',
    'description':
        'Set personalized feeding schedules, preventing overfeeding and promoting water quality for vibrant, thriving fish and plants.',
    'icon': Icons.autorenew, // Assuming you have imported the Icons class
  },
  {
    'title': 'Data-Driven Insights',
    'description':
        'Harness the power of historical data and analytics to make informed decisions, ensuring long-term success for your aquaponics ecosystem.',
    'icon': Icons.leaderboard, // Assuming you have imported the Icons class
  },
  {
    'title': 'Sustainable by Design',
    'description':
        'Our eco-conscious system maximizes efficiency while minimizing environmental impact, promoting sustainable aquaponics practices.',
    'icon': Icons.eco, // Assuming you have imported the Icons class
  },
];

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 1, child: AppLogo()),
              const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Revolutionize your aquaponics venture with the cutting-edge Aquaponia Monitoring App',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: ListView.builder(
                    itemCount: marketingData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10, left: 5, right: 5),
                          child: Details(
                            label: marketingData[index]['title'],
                            description: marketingData[index]['description'],
                            iconData: marketingData[index]['icon'],
                          ));
                    },
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: MaterialButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text('Exit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ))),
                        ),
                        Container(
                          width: 120,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 40, 62, 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: MaterialButton(
                              onPressed: () {
                                Get.toNamed('/dashboard');
                              },
                              child: const Text('Start',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ))),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
