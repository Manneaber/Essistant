import 'dart:io';

import 'package:essistant/main.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentAttachmentData.dart';
import 'package:essistant/repository/data/AssignmentAttachmentType.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AddTaskRoute extends StatefulWidget {
  @override
  _AddTaskRouteState createState() => _AddTaskRouteState();
}

class _AddTaskRouteState extends State<AddTaskRoute> {
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final Color _inputBg = Colors.grey[200];
  SubjectData _selectedSubject;
  int _dueDate;
  List<AssignmentAttachmentData> _attachments = [];
  List<Widget> _addedAttachment = [];
  String _dueDateText = 'ระบุวันที่กำหนดส่ง';
  String _selectedSubjectText = 'วิชา';

  Widget _attachment() {
    return Container(
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
          InkWell(
            onTap: () async {
              var image =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                var localPath = await getApplicationDocumentsDirectory();
                var _appDocDirFolder = Directory(localPath.path + '/img');
                if (!(await _appDocDirFolder.exists())) {
                  await _appDocDirFolder.create(recursive: true);
                }
                var newImage = image.copySync(
                    localPath.path + '/img/' + path.basename(image.path));

                _attachments.add(
                  AssignmentAttachmentData(
                    url: newImage.path,
                    type: AssignmentAttachmentType.IMAGE,
                  ),
                );

                setState(
                  () {
                    final curIndex = _addedAttachment.length;
                    _addedAttachment.add(
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("ต้องการจะลบจริงหรือไม่"),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      navigationKey.currentState.pop();
                                    },
                                    child: Text("ไม่"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      newImage.deleteSync();
                                      setState(() {
                                        _attachments.removeWhere((elem) {
                                          return elem.url == newImage.path;
                                        });
                                        _addedAttachment.removeAt(curIndex);
                                      });

                                      navigationKey.currentState.pop();
                                    },
                                    child: Text("ลบ"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 70),
                              Expanded(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: _inputBg,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(13),
                                  child: Image.file(newImage),
                                ),
                              ),
                              SizedBox(width: 18),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(Icons.attachment),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: _inputBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.all(13),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'เพิ่มไฟล์แนบ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children:
                _addedAttachment.length == 0 ? [Container()] : _addedAttachment,
          ),
        ],
      ),
    );
  }

  Widget _subject() {
    return Container(
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
          InkWell(
            onTap: () async {
              var result =
                  await navigationKey.currentState.pushNamed('/picksubject');

              if (result != null) {
                _selectedSubject = result;
                setState(() {
                  _selectedSubjectText = _selectedSubject.title;
                });
              }
            },
            child: SizedBox(
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
                            _selectedSubjectText,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
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
          ),
        ],
      ),
    );
  }

  Widget _date() {
    return Container(
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
          InkWell(
            onTap: () async {
              DateTime newDateTime = await showRoundedDatePicker(
                context: context,
                theme: ThemeData(primarySwatch: Colors.blue),
                fontFamily: 'Kanit',
                locale: Locale("th", "TH"),
                era: EraMode.BUDDHIST_YEAR,
                styleDatePicker: MaterialRoundedDatePickerStyle(
                  textStyleDayButton: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                  ),
                  textStyleYearButton: TextStyle(
                    //fontSize: 52,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                  ),
                  textStyleDayHeader: TextStyle(
                    //fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                  ),
                  textStyleCurrentDayOnCalendar: TextStyle(
                    //fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kanit',
                  ),
                  textStyleDayOnCalendar: TextStyle(
                    //fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleDayOnCalendarSelected: TextStyle(
                    //fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleDayOnCalendarDisabled: TextStyle(
                    //fontSize: 28,
                    color: Colors.white.withOpacity(0.1),
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleMonthYearHeader: TextStyle(
                    fontFamily: 'Kanit',
                    //fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  paddingDatePicker: EdgeInsets.all(0),
                  paddingMonthHeader: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  paddingActionBar: EdgeInsets.all(0),
                  paddingDateYearHeader: EdgeInsets.fromLTRB(16, 24, 0, 16),
                  sizeArrow: 25,
                  colorArrowNext: Colors.white,
                  colorArrowPrevious: Colors.white,
                  textStyleButtonAction: TextStyle(
                    fontFamily: 'Kanit',
                    //fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleButtonPositive: TextStyle(
                    fontFamily: 'Kanit',
                    //fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleButtonNegative: TextStyle(
                    fontFamily: 'Kanit',
                    //fontSize: 28,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                  decorationDateSelected: BoxDecoration(
                    color: Colors.orange[600],
                    shape: BoxShape.circle,
                  ),
                  backgroundPicker: Colors.blue[600],
                  backgroundActionBar: Colors.blue[500],
                  backgroundHeaderMonth: Colors.blue[400],
                ),
                styleYearPicker: MaterialRoundedYearPickerStyle(
                  textStyleYear: TextStyle(
                    //fontSize: 40,
                    fontFamily: 'Kanit',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textStyleYearSelected: TextStyle(
                    //fontSize: 56,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.bold,
                  ),
                  heightYearRow: 100,
                  backgroundPicker: Colors.blue[400],
                ),
              );

              if (newDateTime != null) {
                _dueDate = newDateTime.millisecondsSinceEpoch;
                setState(() {
                  _dueDateText =
                      DateFormat("dd MMMM yyyy", 'th_TH').format(newDateTime);
                });
              }
            },
            child: SizedBox(
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
                            _dueDateText,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
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
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
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
          InkWell(
            onTap: () {},
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 15),
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(top: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller: _titleController,
                      validator: (val) {
                        if (val.length <= 0) {
                          return "โปรดระบุชื่อการบ้านเพื่อความง่ายในการจำ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'ชื่องาน',
                        fillColor: _inputBg,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 120,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  SizedBox(
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: WillPopScope(
                        child: TextFormField(
                          controller: _descController,
                          decoration: InputDecoration(
                            hintText: 'รายละเอียด',
                            fillColor: _inputBg,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 3,
                        ),
                        onWillPop: () async {
                          if (FocusScope.of(context).hasFocus) {
                            FocusScope.of(context).unfocus();
                            return false;
                          } else {
                            return true;
                          }
                        }),
                  ),
                  SizedBox(width: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onFormSubmited() {
    if (!_form.currentState.validate()) {
      return;
    }

    if (_selectedSubject == null) {
      return;
    }

    var assignment = AssignmentData(
        title: _titleController.text,
        desc: _descController.text,
        color: Colors.blue,
        subject: _selectedSubject,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        dueDate: _dueDate,
        attachments: _attachments);

    AssignmentRepository.insertAssignment(assignment);
    navigationKey.currentState.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("เพิ่มการบ้านใหม่"),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            if (_attachments.length > 0) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("ต้องการจะลบจริงหรือไม่"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            navigationKey.currentState.pop();
                          },
                          child: Text("กลับ"),
                        ),
                        FlatButton(
                          onPressed: () {
                            for (var attachment in _attachments) {
                              File(attachment.url).deleteSync();
                            }

                            navigationKey.currentState.pop();
                            navigationKey.currentState.pop();
                          },
                          child: Text("ลบ"),
                        ),
                      ],
                    );
                  });
            } else {
              navigationKey.currentState.pop();
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _onFormSubmited,
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          children: <Widget>[
            _title(),
            SizedBox(height: 15),
            _subject(),
            SizedBox(height: 15),
            _date(),
            SizedBox(height: 15),
            _attachment(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
