import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final TextEditingController _searchText = new TextEditingController();
  List<Widget> _serchAction;
  Timer _t;

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
              _t = Timer(Duration(seconds: 1), () {
                print(val);
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
    );
  }
}
