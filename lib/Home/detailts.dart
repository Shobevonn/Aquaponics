import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key? key, this.label, this.description, this.iconData})
      : super(key: key);

  final String? label;
  final String? description;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.black12)
      ], borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        width: 120,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(children: [
                Icon(
                  iconData ?? Icons.error,
                  color: const Color.fromARGB(255, 40, 62, 2),
                ),
                const SizedBox(width: 5),
                Text(
                  label ?? 'NONE',
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
              ]),
              Text(description ?? 'NONE',
                  style: const TextStyle(fontFamily: 'Poppins'))
            ],
          ),
        ),
      ),
    );
  }
}
