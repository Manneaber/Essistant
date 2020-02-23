import 'package:essistant/routes/overview_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  List<Widget> _views = [
    OverviewRoute(),
  ];

  Widget _currentView;
  int _currentIndex;

  MainViewState() {
    _currentIndex = 0;
    _currentView = _views[_currentIndex];
  }

  void changeView(int id) {
    setState(() {
      _currentView = _views[id];
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (id) {
          setState(() {
            _currentIndex = id;
          });
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
            title: Text("Note"),
            icon: Icon(Icons.note),
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
