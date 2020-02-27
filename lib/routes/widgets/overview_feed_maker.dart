import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:flutter/material.dart';

class FeedMaker {
  Widget create({String title, @required List<AssignmentData> assignments}) {
    if (assignments == null || assignments.length <= 0)
      throw ("Assignment length should longer than 0");

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(title),
        _buildBody(assignments),
      ],
    );
  }

  Widget _buildTitle(String title) {
    if (title == null) return null;

    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget _buildBody(List<AssignmentData> assignments) {
    List<Widget> lists = [];

    for (var assignment in assignments) {
      lists.add(_FeedTemplate(assignment));
    }

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lists,
      ),
    );
  }
}

class _FeedTemplate extends StatelessWidget {
  final AssignmentData assignment;

  _FeedTemplate(this.assignment);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: <Widget>[
          SizedBox(width: 15),
          SizedBox(
            width: 40,
            height: 40,
            child: Container(color: Colors.blue),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  assignment.title,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  assignment.desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 18),
        ],
      ),
    );
  }
}
