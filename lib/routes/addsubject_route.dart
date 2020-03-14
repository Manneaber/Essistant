import 'package:essistant/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSubjectRoute extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final _key1 = TextEditingController();

  // Color
  final Color _inputBg = Colors.grey[200];

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
            onPressed: () {
              if (_form.currentState.validate()) {
                print('Passed');
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
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
                              controller: _key1,
                              onSaved: (value) {
                                // value
                                print("Value: " + value);
                                FocusScope.of(context).unfocus();
                              },
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
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 18),
                        ],
                      ),
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
                    onTap: () async {},
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              padding: EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'ปีการศึกษา',
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
            ),
          ],
        ),
      ),
    );
  }
}
