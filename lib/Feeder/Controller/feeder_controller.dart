// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:async';
import 'package:aquaponia/Database/database.dart';
import 'package:aquaponia/Feeder/Model/feeder_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeederController extends GetxController {
  final String history = 'feederhistory';
  final String feederConfig = 'feeder';

  final RxInt historyFilter = 1.obs;

  final RxString timeDuration = 'NONE'.obs;

  final TextEditingController timeData = TextEditingController();

  Rxn<List<FeederModel>> currentFeederSchedules =
      Rxn<List<FeederModel>>([]).obs();
  Rxn<List<FeederModel>> historyFeed = Rxn<List<FeederModel>>([]).obs();

  RxString time = ''.obs;

  @override
  void onInit() {
    fetchLatestSchedules();
    fetchFeederRecords();
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      fetchLatestSchedules();
      fetchFeederRecords();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timeDuration.value = retrieveTimeDifference();
      timeDuration.refresh();
    });
    super.onInit();
  }

  void fetchFeederdaysRecords() async {
    List<Map<String, dynamic>> results = await DatabaseConfig()
        .getDaysRecord(history, historyFilter.value == 2 ? 30 : 7);

    int numberOfResults = results.length;

    if (numberOfResults == 0) {
      return;
    }

    if (numberOfResults == historyFeed.value!.length) {
      return;
    }

    historyFeed.value!.clear();

    for (Map<String, dynamic> result in results) {
      historyFeed.value!.add(FeederModel(
        id: result['id'],
        time: result['time'],
        status: RxBool(result['status'] == 0),
        date: DateTime.parse(result['date']),
      ));
    }

    historyFeed.refresh();
  }

  void fetchFeederRecords() async {
    List<Map<String, dynamic>> results =
        await DatabaseConfig().fetchAllData(history);

    int numberOfResults = results.length;

    if (numberOfResults == 0) {
      return;
    }

    if (numberOfResults == historyFeed.value!.length) {
      return;
    }

    historyFeed.value!.clear();

    for (Map<String, dynamic> result in results) {
      historyFeed.value!.add(FeederModel(
        id: result['id'],
        time: result['time'],
        status: RxBool(result['status'] == 0),
        date: DateTime.parse(result['date']),
      ));
    }

    historyFeed.refresh();
  }

  void fetchLatestSchedules() async {
    List<Map<String, dynamic>> results =
        await DatabaseConfig().fetchAllData('feeder');

    int numberOfResults = results.length;

    if (numberOfResults == 0) {
      return;
    }

    if (numberOfResults == currentFeederSchedules.value!.length) {
      return;
    }

    try {
      if (results.isNotEmpty) {
        List<FeederModel> schedules = [];

        for (var result in results) {
          FeederModel feederModel = FeederModel(
            id: result['id'],
            time: result['time'],
            status: RxBool(result['status'] == 0),
            date: DateTime.parse(result['date']),
          );

          schedules.add(feederModel);
        }

        currentFeederSchedules.value = schedules;
        currentFeederSchedules.refresh();
      } else {
        throw Exception('No records found in the database.');
      }
    } catch (err) {
      print(err);
    }
  }

  bool registerSchedule() {
    try {
      DatabaseConfig().insertData({
        'time': timeData.text,
        'status': 0,
        'date': DateTime.now().toIso8601String()
      }, 'feeder');

      currentFeederSchedules.value!.add(FeederModel(
          id: 100,
          time: timeData.text,
          status: RxBool(false),
          date: DateTime.now()));
      currentFeederSchedules.refresh();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  String nearAlarm() {
    if (currentFeederSchedules.value!.isEmpty) {
      return 'NONE';
    }

    FeederModel? nearestFeed = retrieveNeerest();

    return nearestFeed != null ? nearestFeed.time! : 'NONE';
  }

  String retrieveTimeDifference() {
    if (currentFeederSchedules.value!.isEmpty) {
      return 'NONE';
    }

    FeederModel? nearestFeed = retrieveNeerest();

    if (nearestFeed == null) {
      return 'NONE';
    }

    Duration duration =
        calculateTimeDifference(convertTimeStringToDateTime(nearestFeed.time!));

    String hour = duration.inHours == 0
        ? ''
        : duration.inHours > 1
            ? '${duration.inHours} hrs '
            : '${duration.inHours} hr ';

    String minute = duration.inMinutes % 60 == 0
        ? ''
        : duration.inMinutes % 60 > 1
            ? '${duration.inMinutes % 60} mins '
            : '${duration.inMinutes % 60} min ';

    return '$hour $minute';
  }

  FeederModel? retrieveNeerest() {
    FeederModel? nearestFeed;

    DateTime currentTodayTime = DateTime.now();

    for (var element in currentFeederSchedules.value!) {
      if (element.status!.value == false) continue;

      DateTime currentElement = convertTimeStringToDateTime(element.time!);
      if (currentTodayTime.isBefore(currentElement)) {
        if (nearestFeed == null) {
          nearestFeed = element;
          continue;
        }

        if (currentElement
            .isBefore(convertTimeStringToDateTime(nearestFeed.time!))) {
          nearestFeed = element;
        }
      }
    }

    return nearestFeed;
  }

  DateTime convertTimeStringToDateTime(String timeString) {
    DateTime currentDate = DateTime.now();

    List<String> parts = timeString.split(":");
    int hours = int.parse(parts[0]);

    if (timeString.contains("PM") && hours != 12) {
      hours += 12;
    }

    int minutes = int.parse(parts[1].split(" ")[0]);

    return DateTime(
        currentDate.year, currentDate.month, currentDate.day, hours, minutes);
  }

  String parseStringTimeDifference(String timeString) {
    Duration duration =
        calculateTimeDifference(convertTimeStringToDateTime(timeString));

    String hour = duration.inHours == 0
        ? ''
        : duration.inHours > 1
            ? '${duration.inHours} hrs '
            : '${duration.inHours} hr ';

    String minute = duration.inMinutes % 60 == 0
        ? ''
        : duration.inMinutes % 60 > 1
            ? '${duration.inMinutes % 60} mins '
            : '${duration.inMinutes % 60} min ';

    return '$hour $minute';
  }

  Duration calculateTimeDifference(DateTime specifiedTime) {
    DateTime now = DateTime.now();
    Duration difference = specifiedTime.difference(now);
    return difference;
  }
}
