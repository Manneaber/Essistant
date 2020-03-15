import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {

  IconData _gdriveCheck = Icons.check_box_outline_blank;

  _SettingRouteState() {
    updateStatus();
  }

  Future<void> updateStatus() async {
  }

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
          Container(
            margin: EdgeInsets.only(top: 15),
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
