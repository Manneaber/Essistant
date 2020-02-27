import 'package:essistant/repository/GoogleDriveRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {
  final drive = GoogleDriveRepository();

  IconData _gdriveCheck = Icons.check_box_outline_blank;

  _SettingRouteState() {
    updateStatus();
  }

  Future<void> updateStatus() async {
    var check = await drive.isAuthorized();
    if (check) {
      _gdriveCheck = Icons.check_box;
    } else {
      _gdriveCheck = Icons.check_box_outline_blank;
    }

    setState(() {});

    print(check);
  }

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
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 75,
                  child: InkWell(
                    onTap: () {
                      drive.login();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 15),
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.backup, size: 27),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("การสำรองข้อมูล",
                                  style: TextStyle(fontSize: 16)),
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
                              _gdriveCheck,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(width: 70),
                    Expanded(
                      child: Container(
                        color: Colors.grey[300],
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(
                  height: 75,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 15),
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.replay, size: 27),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("สำรองข้อมูลตอนนี้",
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                "สำรองข้อมูลล่าสุด 28 กุมภาพันธ์ 2563 00:21",
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
              ],
            ),
          ),
          SizedBox(height: 15),
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
              height: 75,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.delete, size: 27),
                  ),
                  SizedBox(width: 15),
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
          SizedBox(height: 15),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 15),
                CircleAvatar(
                  radius: 20,
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
                        "Alpha Build 28022020-1",
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
