import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubjectRouteState();
  }
}

class _SubjectRouteState extends State<SubjectRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("วิชา"),
        centerTitle: true,
        elevation: 0.5, //shadow
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                "ปีการศึกษา 2562",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          _buildMagicBox(5)
        ],
      ),
    );
  }

  Widget _buildMagicBox(int n) {
    List<Widget> list = [];

    for (int i = 0; i < n; i++) {
      list.add(_buildBody());
      list.add(_buildSeperator());
    }
    list.removeLast();

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 75,
      padding: EdgeInsets.only(left:25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("title : "), Text("desc : ")],
      ),
    );
  }

  Widget _buildSeperator() {
    return Container(
      height: 1,
      color: Colors.grey,
    );
  }
}
