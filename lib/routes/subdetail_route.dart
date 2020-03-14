import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SubDatailRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubDatailRouteState();
  }
}

class _SubDatailRouteState extends State<SubDatailRoute> {
  Widget _buildCard(List<AssignmentData> data) {
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
            padding: EdgeInsets.only(left: 15,top: 15,bottom: 10),
            child: Text(
              'งานทั้งหมด' ,
              style: TextStyle(fontSize: 22, color: Colors.black),
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
    // TODO: implement build
    final SubjectData subjectData = ModalRoute.of(context).settings.arguments;
    print(subjectData);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("งาน"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future:
                AssignmentRepository.getAllAssignmentsInSubject(subjectData.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return Column(
                    children: [_buildCard(snapshot.data),
                    Container(
                      child: Column(
                        

                      ),
                    ),
                    ],
                  );
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
        ],
      ),
    );
  }
}

Widget _buildBody(AssignmentData subjectData) {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subjectData.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    subjectData.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
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
  return Container(
    height: 1,
    color: Colors.grey,
  );
}
