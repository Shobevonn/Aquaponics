// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:aquaponia/Feeder/Model/feeder_model.dart';
import 'package:intl/intl.dart';
import 'package:aquaponia/Database/database.dart';
import 'package:aquaponia/Home/Notification/notification.dart';
import 'package:get/get.dart';
import 'package:background_fetch/background_fetch.dart';

class BackgroundFetchController extends GetxController {
  @override
  void onInit() {
    initBackgroundFetch();
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    super.onInit();
  }

  void initBackgroundFetch() async {
    print('background task trigger');
    // Step 1:  Configure BackgroundFetch as usual.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 5,
            enableHeadless: true,
            stopOnTerminate: false), (String taskId) async {
      // <-- Event callback.
      // This is the fetch-event callback.
      print("[BackgroundFetch] taskId: $taskId");

      // Use a switch statement to route task-handling.
      switch (taskId) {
        case 'com.phLevel.customtask':
          generatepHLevel();
          break;
        case 'com.temperature.customtask':
          generateTemperature();
        case 'com.feeding.customtask':
          generateFeederRecord();
          break;
        default:
          print("Default fetch task");
      }
      // Finish, providing received taskId.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Event timeout callback
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });

    try {
      Timer.periodic(const Duration(minutes: 1), (timer) async {
        List<FeederModel> feederModels = await fetchSchedules();
        DateTime now = DateTime.now();
        String currentTime = DateFormat('hh:mm a').format(now);

        for (var feederModel in feederModels) {
          if (feederModel.time == currentTime) {
            BackgroundFetch.scheduleTask(TaskConfig(
              taskId: 'com.feeding.customtask',
              delay: 2500,
            ));

            print('Feeding scheduled for ${feederModel.time}');
          }
        }
      });
    } catch (err) {
      print(err);
    }

    Timer.periodic(const Duration(minutes: 1), (timer) {
      // Step 2:  Schedule a custom "oneshot" task "com.transistorsoft.customtask" to execute 5000ms from now.
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.phLevel.customtask", delay: 2500 // <-- milliseconds
          ));

      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.temperature.customtask", delay: 2500 // <-- milliseconds
          )); //Fetch data periodically
    });
  }

  void backgroundFetchHeadlessTask(String taskId) async {
    // This is the headless task that will be triggered even when the app is terminated.
    // Perform the same task as in the onBackgroundFetch callback.
    try {
      switch (taskId) {
        case 'com.phLevel.customtask':
          generatepHLevel();
          break;
        case 'com.temperature.customtask':
          generateTemperature();
          break;
        case 'com.feeding.customtask':
          generateFeederRecord();
        default:
          print("Default fetch task");
      }

      try {
        Timer.periodic(const Duration(minutes: 1), (timer) async {
          List<FeederModel> feederModels = await fetchSchedules();
          DateTime now = DateTime.now();
          String currentTime = DateFormat('hh:mm a').format(now);

          for (var feederModel in feederModels) {
            if (feederModel.time == currentTime) {
              BackgroundFetch.scheduleTask(TaskConfig(
                taskId: 'com.feeding.customtask',
                delay: 2500,
              ));

              print('Feeding scheduled for ${feederModel.time}');
            }
          }
        });
      } catch (err) {
        print(err);
      }

      Timer.periodic(const Duration(minutes: 1), (timer) {
        // Step 2:  Schedule a custom "oneshot" task "com.transistorsoft.customtask" to execute 5000ms from now.
        BackgroundFetch.scheduleTask(TaskConfig(
            taskId: "com.phLevel.customtask", delay: 2500 // <-- milliseconds
            ));

        BackgroundFetch.scheduleTask(TaskConfig(
            taskId: "com.temperature.customtask",
            delay: 2500 // <-- milliseconds
            )); //Fetch data periodically
      });
    } catch (e) {
      print("Exception occurred: $e");
      Notification notification = Notification();
      notification.initialize();
      notification.showNotification(
        id: 1,
        title: 'Error',
        body: 'ph Value update $e',
      );
    }

    // Finish the headless task.
    BackgroundFetch.finish(taskId);
  }

  Future<List<FeederModel>> fetchSchedules() async {
    List<Map<String, dynamic>> results =
        await DatabaseConfig().fetchAllData('feeder');

    List<FeederModel> schedules = [];

    for (var result in results) {
      FeederModel feederModel = FeederModel(
        id: result['id'],
        time: result['time'],
        status: RxBool(result['status'] == 1),
        date: DateTime.parse(result['date']),
      );

      schedules.add(feederModel);
    }

    return schedules;
  }

  void generatepHLevel() async {
    print("Received custom task");

    // Generate a random number from 1 to 14
    Random random = Random();
    int phLevel = random.nextInt(14) + 1;

    // Get current date and time
    String datetime = DateTime.now().toIso8601String();

    // Create a row to insert into the database
    Map<String, dynamic> row = {
      'ph_level_value': phLevel,
      'create_at': datetime,
    };

    if (phLevel < 7) {
      Notification notification = Notification();
      notification.initialize();
      notification.showNotification(
        id: phLevel,
        title: 'New pH level',
        body: 'Acidic pH level detected $phLevel pH',
      );
    }

    // Insert the data into the SQLite database
    DatabaseConfig databaseConfig = DatabaseConfig();
    int result = await databaseConfig.insertData(row, 'phlevel');

    print("Inserted $result row(s) into the database.");
  }

  void generateTemperature() async {
    print("Received custom task");

    // Generate a random number from 1 to 14
    Random random = Random();
    int temperature = random.nextInt(40) + 1;

    // Get current date and time
    String datetime = DateTime.now().toIso8601String();

    // Create a row to insert into the database
    Map<String, dynamic> row = {
      'temperature_value': temperature,
      'create_at': datetime,
    };

    if (temperature > 30) {
      Notification notification = Notification();
      notification.initialize();
      notification.showNotification(
        id: temperature,
        title: 'New Temperature',
        body: 'Hot Temperature $temperature C\u00B0',
      );
    }

    // Insert the data into the SQLite database
    DatabaseConfig databaseConfig = DatabaseConfig();
    int result = await databaseConfig.insertData(row, 'temperature');

    print("Inserted $result row(s) into the database.");
  }

  void generateFeederRecord() async {
    // Generate a random number from 1 to 14
    Random random = Random();
    int feeder = random.nextInt(99) + 1;

    DateTime now = DateTime.now();

    String formattedTime = DateFormat('hh:mm a').format(now);

    // Get current date and time
    String datetime = DateTime.now().toIso8601String();

    // Create a row to insert into the database
    Map<String, dynamic> row = {
      'time': formattedTime,
      'status': 1,
      'date': datetime,
    };

    Notification notification = Notification();
    notification.initialize();
    notification.showNotification(
      id: feeder,
      title: 'Feeding time',
      body: 'feed for today $formattedTime',
    );

    // Insert the data into the SQLite database
    DatabaseConfig databaseConfig = DatabaseConfig();
    int result = await databaseConfig.insertData(row, 'feederhistory');

    print("Inserted $result row(s) into the database.");
  }
}
