import 'package:essistant/routes/main_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        unselectedWidgetColor: Colors.white60,
        bottomAppBarColor: Colors.blue,
        fontFamily: 'Kanit'
      ),
      home: MainView(),
    );
  }
}
