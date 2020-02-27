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
              child: ListView.separated(
                  separatorBuilder: (context, position) {
                    return Container(
                      child: Text("subject : " + (position + 1).toString()),
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                    );
                  },
                  itemBuilder: (context, position) {
                    return Container(
                      height: 70,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black12,
                      ),
                    );
                  },
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
