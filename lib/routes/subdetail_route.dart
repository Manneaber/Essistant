import 'package:essistant/NotificationCenter.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class SubDatailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubDatailRouteState();
  }
}

class _SubDatailRouteState extends State<SubDatailRoute> {
  Widget _buildCard(List<AssignmentData> data, {String title}) {
    List<Widget> children = [];

    for (int i = 0; i < data.length; i++) {
      if (i != 0) children.add(_buildSeperator());
      children.add(_buildBody(data[i]));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title != null
              ? Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              : Container(
                  height: 15,
                ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.fromBorderSide(
                BorderSide(color: Colors.grey[300], width: 0.5),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AssignmentData assignmentData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          navigationKey.currentState
              .pushNamed('/assignmentdetail', arguments: assignmentData);
        },
        child: SizedBox(
          height: 75,
          child: Row(
            children: <Widget>[
              SizedBox(width: 15),
              SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      assignmentData.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                    assignmentData.desc.length > 0
                        ? Text(
                            assignmentData.desc,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        : Container(),
                    Text(
                      assignmentData.dueDate != null
                          ? "กำหนดส่ง " +
                              DateFormat('dd MMMM yyyy', 'th_TH').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      assignmentData.dueDate))
                          : "ไม่มีกำหนดส่ง",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeperator() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(width: 70),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            height: 0.5,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SubjectData subjectData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("งานของ " + subjectData.title),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("ต้องการลบจริงหรือไม่"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          navigationKey.currentState.pop();
                        },
                        child: Text("ยกเลิก"),
                      ),
                      FlatButton(
                        onPressed: () async {
                          await AssignmentRepository.removeSubjectByID(
                              subjectData.id);
                          await NotificationCenter.cancel(id: subjectData.id);
                          navigationKey.currentState.pop();
                          navigationKey.currentState.pop();
                        },
                        child: Text("ลบ"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              navigationKey.currentState.pushNamed("/addtask", arguments: {
                "subject": subjectData,
              });
            },
          ),
        ],
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          FutureBuilder(
            future:
                AssignmentRepository.getAllAssignmentsInSubject(subjectData.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  List<AssignmentData> doneList = [];
                  List<AssignmentData> pendingList = [];
                  List<AssignmentData> data = snapshot.data;

                  for (var elem in data) {
                    if (elem.status == 1)
                      doneList.add(elem);
                    else
                      pendingList.add(elem);
                  }

                  return Column(
                    children: [
                      pendingList.length > 0
                          ? _buildCard(pendingList, title: 'งานที่ยังไม่เสร็จ')
                          : Container(),
                      doneList.length > 0
                          ? _buildCard(doneList, title: 'งานที่เสร็จแล้ว')
                          : Container(),
                    ],
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Center(
                      child: Text(
                        'ดีใจจัง ไม่มีงานเลย',
                        style: TextStyle(fontSize: 17, color: Colors.black45),
                      ),
                    ),
                  );
                }
              } else {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
