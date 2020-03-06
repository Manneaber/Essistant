import 'package:essistant/main.dart';
import 'package:flutter/material.dart';

class AddTaskRoute extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final _key1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มการบ้านใหม่"),
        centerTitle: true,  
        elevation: 0,
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
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 75,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          SizedBox(
                            width: 40,
                            height: 40,
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
                                  return "โปรดระบุชื่อการบ้านเพื่อความง่ายในการจำ";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'ชื่องาน',
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 18),
                        ],
                      ),
                    ),
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'รายละเอียด',
                                fillColor: Colors.grey[300],
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
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 75,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 15),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(Icons.ac_unit),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              padding: EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'วิชา',
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
