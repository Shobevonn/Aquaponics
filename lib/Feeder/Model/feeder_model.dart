import 'package:get/get.dart';

class FeederModel {
  int? id;
  String? time;
  RxBool? status;
  DateTime? date;

  FeederModel(
      {required this.id,
      required this.time,
      required this.status,
      required this.date});
}
