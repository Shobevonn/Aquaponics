import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReturnWithLogo extends StatelessWidget {
  const ReturnWithLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 0.5)
            ], borderRadius: BorderRadius.all(Radius.circular(13))),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              child: Center(
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Color.fromARGB(255, 40, 62, 2)))),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.eco,
                color: Color.fromARGB(255, 40, 62, 2),
                size: 32,
              ),
              Text(
                'Aquaponia',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 40, 62, 2)),
              )
            ],
          ),
          const SizedBox(
            width: 10,
            height: 10,
          )
        ],
      ),
    );
  }
}
