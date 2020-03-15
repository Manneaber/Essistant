import 'dart:async';

import 'package:essistant/main.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final TextEditingController _searchText = new TextEditingController();
  List<Widget> _serchAction;
  Timer _t;
  List<Widget> _searchList = [];
  String _keyword = "";

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
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.5,
          actions: _serchAction,
          title: SizedBox(
            height: 45,
            child: TextField(
              controller: _searchText,
              onChanged: (val) {
                if (_t != null && _t.isActive) {
                  _t.cancel();
                }
                _t = Timer(Duration(milliseconds: 250), () {
                  setState(() {
                    _keyword = val;
                  });
                });
              },
              onTap: () {
                setState(() {
                  _serchAction = [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _serchAction = null;
                          _searchText.clear(); // clear text
                          FocusScope.of(context).unfocus(); //hide keybord
                          setState(() {
                            _keyword = "";
                          });
                        });
                      },
                      child: Text(
                        "ยกเลิก",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ];
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: "ค้นหาอะไรก็ได้ แค่พิมพ์ที่นี่...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.hasData != null) {
              List<AssignmentData> data = snapshot.data;
              if (data.length > 0) {
                return _buildCard(data);
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ไม่พบข้อมูล',
                        style: TextStyle(fontSize: 17, color: Colors.black45),
                      )
                    ],
                  ),
                );
              }
            }

            return Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ค้นหาได้เลย',
                    style: TextStyle(fontSize: 17, color: Colors.black45),
                  )
                ],
              ),
            );
          },
          future: AssignmentRepository.findAssignmentByKeyword(_keyword),
        ));
  }
}
