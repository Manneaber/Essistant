import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {
  _SettingRouteState() {
    updateStatus();
  }

  Future<void> updateStatus() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ตั้งค่า"),
        centerTitle: true,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 15),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.fromBorderSide(
                BorderSide(color: Colors.grey[300], width: 0.5),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("ลบทั้งหมด?"),
                          content: Text("แน่ใจนะว่าจะลบทั้งหมด"),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("ไม่"),
                            ),
                            FlatButton(
                              onPressed: () async {
                                await AssignmentRepository.clearAll();
                                Navigator.of(context).pop();
                              },
                              child: Text("ใช่"),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 15),
                    SizedBox(
                      width: 40,
                      child: Icon(Icons.delete, size: 27),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ลบข้อมูลทั้งหมด",
                              style: TextStyle(fontSize: 16)),
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
          ),
          SizedBox(height: 15),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.fromBorderSide(
                BorderSide(color: Colors.grey[300], width: 0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 15),
                SizedBox(
                  width: 40,
                  child: Icon(Icons.info, size: 27),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Essistant", style: TextStyle(fontSize: 16)),
                      Text(
                        "Beta Build 20102020-1",
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
