import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final TextEditingController _searchText = new TextEditingController();
  List<Widget> _serchAction;

  void test() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_action_name');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (a,b,c,d) {});
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(minutes: 1));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1534523462376',
        'Misc',
        'Misc Test Channel');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
    print('scheduled');
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    test();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.5,
        actions: _serchAction,
        title: SizedBox(
          height: 45,
          child: TextField(
            controller: _searchText,
            onTap: () {
              setState(() {
                _serchAction = [
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _serchAction = null;
                        _searchText.clear(); // clear text
                        FocusScope.of(context).unfocus(); //hide keybord
                      });
                    },
                    child: Text(
                      "ยกเลิก",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ];
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              hintText: "ค้นหาอะไรก็ได้ แค่พิมพ์ที่นี่...",
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
