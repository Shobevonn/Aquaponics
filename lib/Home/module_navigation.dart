import 'package:flutter/material.dart';

class ModuleNavigation extends StatelessWidget {
  const ModuleNavigation({Key? key, this.title, this.value, this.icon})
      : super(key: key);

  final String? title;
  final String? value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 62, 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                child: Stack(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Color.fromARGB(228, 255, 255, 255),
                            ),
                            child: Center(
                              child: Text(
                                value ?? 'NONE',
                                style: const TextStyle(
                                    fontSize: 35,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 2,
                        right: 0,
                        child: Icon(
                          icon ?? Icons.error,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Text(title ?? 'NONE',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
