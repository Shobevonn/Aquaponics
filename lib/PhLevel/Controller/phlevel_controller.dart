// ignore_for_file: avoid_print

import 'dart:async';

import 'package:aquaponia/Database/database.dart';
import 'package:aquaponia/PhLevel/Model/Phlevel_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PhLevelController extends GetxController {
  final String phLevel = 'phlevel';
  RxInt phlevelFilter = 1.obs;

  Rxn<PhLevel>? latestPhLevel = Rxn<PhLevel>(null).obs();
  Rxn<List<PhLevel>> phLevels = Rxn<List<PhLevel>>([]).obs();

  Rxn<List<FlSpot>> flSpots = Rxn<List<FlSpot>>([]).obs();

  @override
  void onInit() {
    fetchLatestRecord();
    fetchPhRecords();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchLatestRecord();
      fetchPhRecords(); // Fetch data periodically
    });
    phLevels.listen((p0) {
      if (p0 == null) {
        return;
      }

      if (p0.isEmpty) {
        return;
      }

      flSpots.value = listOfpH();
      flSpots.refresh();
    });
    super.onInit();
  }

  void fetchdaysRecords() async {
    List<Map<String, dynamic>> results = await DatabaseConfig()
        .getDaysRecord(phLevel, phlevelFilter.value == 2 ? 30 : 7);

    int numberOfResults = results.length;

    if (numberOfResults == 0) {
      return;
    }

    phLevels.value!.clear();

    for (Map<String, dynamic> result in results) {
      phLevels.value!.add(PhLevel(
        id: result['id'],
        value: result['ph_level_value'],
        date: DateTime.parse(result['create_at']),
      ));
    }

    phLevels.refresh();
  }

  void fetchPhRecords() async {
    List<Map<String, dynamic>> results =
        await DatabaseConfig().fetchAllData('phlevel');

    int numberOfResults = results.length;

    if (numberOfResults == phLevels.value!.length) {
      return;
    }

    phLevels.value!.clear();

    for (Map<String, dynamic> result in results) {
      phLevels.value!.add(PhLevel(
        id: result['id'],
        value: result['ph_level_value'],
        date: DateTime.parse(result['create_at']),
      ));
    }

    phLevels.refresh();
  }

  void fetchLatestRecord() async {
    List<Map<String, dynamic>> results =
        await DatabaseConfig().getLatestPHLevel('phlevel');

    try {
      if (results.isNotEmpty) {
        Map<String, dynamic> result = results.first;
        latestPhLevel?.value = PhLevel(
          id: result['id'],
          value: result['ph_level_value'],
          date: DateTime.parse(result['create_at']),
        );
      } else {
        throw Exception('No records found in the database.');
      }
    } catch (err) {
      print(err);
    }
  }

  NeedlePointer get phValue => NeedlePointer(
      value: double.parse(latestPhLevel!.value!.value.toString()));

  List<FlSpot> listOfpH() {
    List<FlSpot> list = [];

    if (phLevels.value!.isEmpty) return list;

    for (int i = 0; i <= 10; i++) {
      double x = double.parse(i.toString());
      double y = double.parse(phLevels.value![i].value.toString());

      list.add(FlSpot(x, y));
    }

    return list;
  }
}
