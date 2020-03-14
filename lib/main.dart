import 'package:camera/camera.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/routes/TakePictureScreen.dart';
import 'package:essistant/routes/addsubject_route.dart';
import 'package:essistant/routes/addtask_route.dart';
import 'package:essistant/routes/main_view.dart';
import 'package:essistant/routes/subjectpicker_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

final navigationKey = GlobalKey<NavigatorState>();
final db = AssignmentRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  db.init();
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
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
        '/addsubject': (context) => AddSubjectRoute(),
        '/picksubject': (context) => SubjectPickerRoute(),
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
