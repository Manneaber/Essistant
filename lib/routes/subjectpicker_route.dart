import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/material.dart';
import 'package:essistant/main.dart';

class SubjectPickerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubjectPickerRouteState();
}

class _SubjectPickerRouteState extends State<SubjectPickerRoute> {
  Widget _buildCard(List<SubjectData> data) {
    List<Widget> children = [];

    for (int i = 0; i < data.length; i++) {
      if (i != 0) children.add(_buildSeperator());
      children.add(_buildItem(data[i]));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15),
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
      appBar: AppBar(
        elevation: 0.5,
        title: Text("เลือกวิชา"),
        centerTitle: true,
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

                  ..sort((e1, e2) => int.parse(e2.key)
                      .compareTo(int.parse(e1.key))));

                for (List<SubjectData> subjs in newMap.values) {
                  cards.add(_buildCard(subjs));
                }

                if (cards.length > 0) {
                  return Column(children: cards);
                } else {
                  return Container();
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
          SizedBox(height: 15),
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
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      navigationKey.currentState.pushNamed("/addsubject");
                    },
                    child: SizedBox(
                      height: 75,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "เพิ่มรายวิชาใหม่",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(SubjectData subjectData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          navigationKey.currentState.pop(subjectData);
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
