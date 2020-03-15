import 'dart:io';

import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentAttachmentData.dart';
import 'package:essistant/repository/data/AssignmentAttachmentType.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:essistant/routes/displaypicture_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AssignmentDetailRoute extends StatefulWidget {
  @override
  _AssignmentDetailRouteState createState() => _AssignmentDetailRouteState();
}

class _AssignmentDetailRouteState extends State<AssignmentDetailRoute> {
  final Color _inputBg = Colors.grey[200];
  bool _isDone;

  Widget _attachment(List<AssignmentAttachmentData> attachs) {
    List<Widget> attachsWidget = [];
    for (var attach in attachs) {
      IconData iconData;
      switch (attach.type) {
        case AssignmentAttachmentType.IMAGE:
          iconData = Icons.image;
          break;
        case AssignmentAttachmentType.VOICE:
          iconData = Icons.keyboard_voice;
          break;
        case AssignmentAttachmentType.VIDEO:
          iconData = Icons.videocam;
          break;
        case AssignmentAttachmentType.PDF:
          iconData = Icons.picture_as_pdf;
          break;
        case AssignmentAttachmentType.UNDEFINED:
          iconData = Icons.attach_file;
          break;
      }

      attachsWidget.add(
        InkWell(
          onTap: () {
            navigationKey.currentState.push(
              MaterialPageRoute(
                builder: (c) => DisplayPictureRoute(
                  imagePath: attach.url,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(iconData),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Image.file(
                      File(attach.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
          ),
        ),
      );
    }

    if (attachsWidget.length != 0) {
      return Container(
        margin: EdgeInsets.only(top: 15),
        width: double.maxFinite,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey[300], width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: attachsWidget,
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _subject(SubjectData subjectData) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(Icons.subject),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          subjectData.title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _date(int dueDate) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(Icons.calendar_today),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dueDate != null
                              ? DateFormat("dd MMMM yyyy", 'th_TH').format(
                                  DateTime.fromMillisecondsSinceEpoch(dueDate))
                              : "ไม่มีกำหนดส่ง",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String title, {Color color = Colors.blue, String desc}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundColor: color,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 15),
              SizedBox(
                width: 40,
                height: 40,
              ),
              SizedBox(width: 15),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 120.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: EdgeInsets.all(13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          desc.length == 0 ? "ไม่มีคำอธิบาย" : desc,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _markAsDone(int assignmentID) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: FlatButton(
          color: Colors.blue[400],
          textColor: Colors.white,
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("ต้องการทำเครื่องหมายว่าเสร็จแล้วใช่หรือไม่"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        navigationKey.currentState.pop();
                      },
                      child: Text("ไม่"),
                    ),
                    FlatButton(
                      onPressed: () async {
                        await AssignmentRepository.updateAssignmentStatusByID(
                            assignmentID, 1);
                        setState(() {
                          _isDone = true;
                        });
                        navigationKey.currentState.pop();
                      },
                      child: Text("ใช่"),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('ทำเครื่องหมายว่าเสร็จแล้ว')),
    );
  }

  Widget _delete(int assignmentID) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: FlatButton(
        color: Colors.red[400],
        textColor: Colors.white,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("ต้องการลบจริงหรือไม่"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      navigationKey.currentState.pop();
                    },
                    child: Text("ยกเลิก"),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await AssignmentRepository.removeAssignmentByID(
                          assignmentID);
                      navigationKey.currentState.pop();
                      navigationKey.currentState.pop();
                    },
                    child: Text("ลบ"),
                  ),
                ],
              );
            },
          );
        },
        child: Text('ลบ'),
      ),
    );
  }

  Widget _buildComplete(AssignmentData assignmentData) {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _title(assignmentData.title,
            color: assignmentData.color, desc: assignmentData.desc),
        _attachment(assignmentData.attachments),
        _subject(assignmentData.subject),
        _date(assignmentData.dueDate),
        assignmentData.status == 1
            ? Container()
            : _markAsDone(assignmentData.id),
        _delete(assignmentData.id),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Center(
        child: Text(
          'กำลังโหลดข้อมูล...',
          style: TextStyle(fontSize: 17, color: Colors.black45),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AssignmentData sendedData = ModalRoute.of(context).settings.arguments;

    if (_isDone == null) _isDone = sendedData.status == 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("รายละเอียดการบ้าน"),
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: _isDone ? Colors.black26 : Colors.black,
            ),
            onPressed: () async {
              if (_isDone) return;
              await navigationKey.currentState.pushNamed("/edittask",
                  arguments:
                      AssignmentRepository.findAssignmentByID(sendedData.id));
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            AssignmentData assignmentData = snapshot.data;

            return _buildComplete(assignmentData);
          } else {
            return _buildLoading();
          }
        },
        future: AssignmentRepository.findAssignmentByID(sendedData.id),
      ),
    );
  }
}
