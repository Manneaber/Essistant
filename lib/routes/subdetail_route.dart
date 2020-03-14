import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubDatailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubDatailRouteState();
  }
}

class _SubDatailRouteState extends State<SubDatailRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("งาน"),
        centerTitle: true,
      ),
      body: ListView(
        
        children: <Widget>[
          
        ],
      ),
    );
  }
}
