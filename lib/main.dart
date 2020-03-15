import 'package:essistant/NotificationCenter.dart';
import 'package:essistant/routes/addsubject_route.dart';
import 'package:essistant/routes/addtask_route.dart';
import 'package:essistant/routes/assignmentdetail_route.dart';
import 'package:essistant/routes/edittask_route.dart';
import 'package:essistant/routes/main_view.dart';
import 'package:essistant/routes/subdetail_route.dart';
import 'package:essistant/routes/subjectpicker_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationCenter.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          accentColor: Colors.blue,
          unselectedWidgetColor: Colors.black45,
          bottomAppBarColor: Colors.white,
          primaryTextTheme: TextTheme(),
          fontFamily: 'Kanit'),
      home: MainView(),
      routes: {
        '/main': (context) => MainView(),
        '/addtask': (context) => AddTaskRoute(),
        '/edittask': (context) => EditTaskRoute(),
        '/addsubject': (context) => AddSubjectRoute(),
        '/picksubject': (context) => SubjectPickerRoute(),
        '/subjectdetail' : (context) => SubDatailRoute(),
        '/assignmentdetail' : (context) => AssignmentDetailRoute(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      navigatorKey: navigationKey,
    );
  }
}
