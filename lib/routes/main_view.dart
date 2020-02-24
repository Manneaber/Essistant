import 'package:essistant/routes/calenda_route.dart';
import 'package:essistant/routes/overview_route.dart';
import 'package:essistant/routes/search_route.dart';
import 'package:essistant/routes/setting_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  List<Widget> _views = [
    OverviewRoute(),
    SearchRoute(),
    CalendaRoute(),
    SettingRoute(),
  ];

  Widget _currentView;
  int _currentIndex;

  MainViewState() {
    _currentIndex = 0;
    _currentView = _views[_currentIndex];
  }

  void changeView(int id) {
    setState(() {
      _currentIndex = id;
      _currentView = _views[_currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (id) {
          changeView(id);
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Overview"),
            icon: Icon(Icons.book),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            title: Text("Search"),
            icon: Icon(Icons.search),
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            title: Text("Calenda"),
            icon: Icon(Icons.calendar_today),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(Icons.settings),
            backgroundColor: Colors.green,
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: _currentView,
    );
  }
}
