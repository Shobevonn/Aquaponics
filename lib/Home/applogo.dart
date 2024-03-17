import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            child: Image.asset(
          './assets/logo/logo_icon.png',
          height: 45,
        )),
        const Text(
          'Aquaponia',
          style: TextStyle(
              fontFamily: 'Poiret One',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 40, 62, 2)),
        )
      ],
    );
  }
}
