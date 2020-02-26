

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ตั้งค่า"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Icon(Icons.backup, size: 35),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("การสำรองข้อมูล", style: TextStyle(fontSize: 16)),
                        Text(
                          "คุณสามารถเลือกสำรองข้อมูลได้ที่ Google Drive",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("ลบทั้งหมด?"),
                      content: Text("แน่ใจนะว่าจะลบทั้งหมด"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("YES")),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No")),
                      ],
                    );
                  });
            },
            child: Container(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Icon(Icons.delete, size: 35),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ลบข้อมูลทั้งหมด", style: TextStyle(fontSize: 16)),
                        Text(
                          "ลบข้อมูลการบ้านและรายวิชาทั้งหมด",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Icon(Icons.info, size: 35),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Essistant", style: TextStyle(fontSize: 16)),
                      Text(
                        "Alpha Build 25022020-1",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
