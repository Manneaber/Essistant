import 'package:essistant/main.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationCenter {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static NotificationDetails _assignmentChannel;

  static Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_action_name');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (a, b, c, d) async {});
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    _assignmentChannel = NotificationDetails(
      AndroidNotificationDetails(
        '1534523462376',
        'Assignment',
        'Assignment due date alert',
      ),
      iOSPlatformChannelSpecifics,
    );
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) {
      var splited = payload.split("-");

      if (splited.length != 2) return;

      navigationKey.currentState.pushNamed('/assignmentdetail', arguments: AssignmentData(id: int.tryParse(splited[1])));
    }
  }

  static Future<void> sendScheduledToAssignmentChannel({
    @required int id,
    @required String title,
    @required String body,
    @required DateTime time,
  }) {
    return _flutterLocalNotificationsPlugin.schedule(
        id, title, body, time, _assignmentChannel,
        androidAllowWhileIdle: true, payload: "ass-" + id.toString());
  }

  static Future<void> cancel({
    @required int id,
  }) {
    return _flutterLocalNotificationsPlugin.cancel(id);
  }
}
