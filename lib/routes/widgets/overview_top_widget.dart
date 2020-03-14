import 'package:flutter/material.dart';

class OverviewTop extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _OverviewTopState();

  @override
  Size get preferredSize => Size(double.maxFinite, 60);
}

class _OverviewTopState extends State<OverviewTop> {
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey[300], width: 0.5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
          15, 15 + MediaQuery.of(context).padding.top, 15, 15),
      child: Text(
        'Title',
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }
}
