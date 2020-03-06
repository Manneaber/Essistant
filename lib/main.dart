import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/routes/addtask_route.dart';
import 'package:essistant/routes/main_view.dart';
import 'package:flutter/material.dart';

final navigationKey = GlobalKey<NavigatorState>();
final db = AssignmentRepository();

void main() {
  runApp(MyApp());

  db.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          unselectedWidgetColor: Colors.white60,
          bottomAppBarColor: Colors.blue,
          fontFamily: 'Kanit'),
      home: MainView(),
      routes: {
        '/main': (context) => MainView(),
        '/addtask': (context) => AddTaskRoute(),
      },
      navigatorKey: navigationKey,
    );
  }
}
