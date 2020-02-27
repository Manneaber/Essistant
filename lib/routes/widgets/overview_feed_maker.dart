import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  Widget _buildBody(List<AssignmentData> assignments) {
    List<Widget> lists = [];

    for (var assignment in assignments) {
      lists.add(_FeedTemplate(assignment));
      lists.add(_buildSeperator());
    }
    lists.removeLast();

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lists,
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
            color: Colors.black12,
            height: 1,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}

class _FeedTemplate extends StatelessWidget {
  final AssignmentData assignment;

  _FeedTemplate(this.assignment);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                    assignment.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                  ),
                  Text(
                    "กำหนดส่ง " +
                        DateFormat("dd MMMM yyyy H:m", 'en_US')
                            .format(assignment.dueDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
