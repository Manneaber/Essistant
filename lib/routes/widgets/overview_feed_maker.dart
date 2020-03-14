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
        _buildMagicBox(assignments),
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

  Widget _buildMagicBox(List<AssignmentData> assignments) {
    List<Widget> lists = [];

    for (var assignment in assignments) {
      if (lists.length != 0) lists.add(_buildSeperator());
      if (assignment.dueDate != null) lists.add(_buildBody(assignment));
    }

    return Container(
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
            color: Colors.grey[300],
            height: 0.5,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildBody(AssignmentData assignment) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
                      assignment.subject.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
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
}
