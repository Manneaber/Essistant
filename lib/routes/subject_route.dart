import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubjectRouteState();
  }
}

class _SubjectRouteState extends State<SubjectRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("วิชา"),
        centerTitle: true,
        elevation: 0, //shadow
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text("ปีการศึกษา 2562", style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListView.separated(
                  itemBuilder: (context, position) {
                    return Container(
                      child: Text(position.toString()),
                    );
                  },
                  separatorBuilder: (context, position) {
                    return Container(
                      height: 70,
                      width: double.maxFinite,
                      color: Colors.black12,
                    );
                  },
                  itemCount: 5),
            ),
          ),
        ],
      ),
    );
  }
}
