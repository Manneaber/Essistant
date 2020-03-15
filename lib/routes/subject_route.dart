import 'package:essistant/main.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubjectRouteState();
  }
}

class _SubjectRouteState extends State<SubjectRoute> {
  Widget _buildCard(List<SubjectData> data) {
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
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              'ปีการศึกษา ' + data[0].year,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                navigationKey.currentState.pushNamed('/addsubject');
              }),
        ],
        title: Text("วิชา"),
        centerTitle: true,
        elevation: 0.5, //shadow
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 15),
          FutureBuilder(
            future: AssignmentRepository.getAllSubject(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, List<SubjectData>> subjectMap = Map();
                List<Widget> cards = [];

                for (SubjectData elem in snapshot.data) {
                  if (subjectMap.containsKey(elem.year)) {
                    var y = subjectMap[elem.year];
                    y.add(elem);
                    subjectMap[elem.year] = y;
                  } else {
                    subjectMap[elem.year] = [elem];
                  }
                }
                // Sort
                var newMap = Map.fromEntries(subjectMap.entries.toList()
                  ..sort((e1, e2) =>
                      int.parse(e2.key).compareTo(int.parse(e1.key))));

                for (List<SubjectData> subjs in newMap.values) {
                  cards.add(_buildCard(subjs));
                }

                if (cards.length > 0) {
                  return Column(children: cards);
                } else {
                  return Container();
                }
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      'กำลังโหลดข้อมูล...',
                      style: TextStyle(fontSize: 17, color: Colors.black45),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(SubjectData subjectData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          navigationKey.currentState
              .pushNamed('/subjectdetail', arguments: subjectData);
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
                      subjectData.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    ),
                    subjectData.teacher.length > 0 ? Text(
                      subjectData.teacher,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ) : Container(),
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
}
