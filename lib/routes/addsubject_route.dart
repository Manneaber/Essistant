import 'package:essistant/main.dart';
import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSubjectRoute extends StatefulWidget {
  @override
  _AddSubjectRouteState createState() => _AddSubjectRouteState();
}

class _AddSubjectRouteState extends State<AddSubjectRoute> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _year = TextEditingController();

  final Color _inputBg = Colors.grey[200];
  Color _tagColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("เพิ่มวิชาใหม่"),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            navigationKey.currentState.pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (_form.currentState.validate()) {
                FocusScope.of(context).unfocus();
                var subjData = SubjectData(
                  title: _title.text,
                  teacher: _desc.text,
                  color: _tagColor,
                  year: _year.text,
                );

                var res = await AssignmentRepository.insertSubject(subjData);
                if (res) {
                  navigationKey.currentState.pop();
                } else {}
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          children: <Widget>[
            Container(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () async {
                            var res = await navigationKey.currentState
                                .pushNamed('/colorselect');
                            Color col = res;
                            if (col != null) {
                              setState(() {
                                _tagColor = col;
                              });
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(top: 15),
                            child: CircleAvatar(
                              backgroundColor: _tagColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: _title,
                            validator: (val) {
                              if (val.length <= 0) {
                                return "โปรดระบุชื่อวิชา";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'ชื่อวิชา',
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          SizedBox(
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              controller: _desc,
                              decoration: InputDecoration(
                                hintText: 'ชื่อผู้สอน (ไม่จำเป็น)',
                                fillColor: _inputBg,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
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
                            child: Icon(Icons.calendar_today),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              controller: _year,
                              validator: (val) {
                                if (val.length <= 0) {
                                  return "โปรดระบุปีการศึกษา";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'ปีการศึกษา',
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
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
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
            )
          ],
        ),
      ),
    );
  }
}
