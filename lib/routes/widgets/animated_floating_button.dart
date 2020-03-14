import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:essistant/routes/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final void Function() onPressed;
  final Color backgroundColor;
  final Color pressedBackgroundColor;
  final Color iconColor;

  const AnimatedFloatingButton({
    Key key,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.pressedBackgroundColor = Colors.red,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AnimatedFloatingButtonState(this.backgroundColor);
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton> {
  bool _openDrawer = false;
  IconData _icon = Icons.add;
  Color _buttonColor;
  double _translateX = 500;

  _AnimatedFloatingButtonState(Color backgroundColor) {
    _buttonColor = backgroundColor;
  }

  void toggleState() {
    if (!_openDrawer) {
      _icon = Icons.close;
      _buttonColor = widget.pressedBackgroundColor;
      _translateX = 0;
    } else {
      _icon = Icons.add;
      _buttonColor = widget.backgroundColor;
      _translateX = 500;
    }
    setState(() {
      _openDrawer = !_openDrawer;
    });

    // Callback
    if (widget.onPressed != null) widget.onPressed();
  }

  Widget _toggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(
            visible: _openDrawer,
            child: Text("ปิด",
                style: TextStyle(fontSize: 16, color: Colors.white))),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
            toggleState();
          },
          heroTag: "toggle",
          backgroundColor: _buttonColor,
          child: Icon(_icon, color: widget.iconColor),
        ),
      ],
    );
  }

  Widget _assignment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("เพิ่มงานใหม่",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
            navigationKey.currentState.pushNamed('/addtask');
          },
          heroTag: "task",
          backgroundColor: widget.backgroundColor,
          child: Icon(Icons.book, color: widget.iconColor),
        ),
      ],
    );
  }

  Widget _voice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("เพิ่มคลิปเสียง",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
          heroTag: "sound",
          backgroundColor: widget.backgroundColor,
          child: Icon(Icons.keyboard_voice, color: widget.iconColor),
        ),
      ],
    );
  }

  Widget _image() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("เพิ่มรูปภาพ",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Gallery"),
                            onTap: () async {
                              var img = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayPictureScreen(imagePath: img.path),
                                ),
                              );
                            },
                          ),
                          GestureDetector(
                            child: Text("Camera"),
                            onTap: () async {
                              final cameras = await availableCameras();

                              // Get a specific camera from the list of available cameras.
                              final firstCamera = cameras.first;
                              navigationKey.currentState.push(
                                MaterialPageRoute(
                                    builder: (c) =>
                                        TakePictureScreen(camera: firstCamera)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          heroTag: "img",
          backgroundColor: widget.backgroundColor,
          child: Icon(Icons.camera_alt, color: widget.iconColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: _openDrawer,
          child: Transform(
            transform: Matrix4.translationValues(
              16,
              16,
              0.0,
            ),
            child: GestureDetector(
              onTap: () {
                toggleState();
              },
              child: Container(
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                  _translateX,
                  -30,
                  0.0,
                ),
                child: _image(),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  _translateX,
                  -20,
                  0.0,
                ),
                child: _voice(),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  _translateX,
                  -10,
                  0.0,
                ),
                child: _assignment(),
              ),
              _toggle(),
            ],
          ),
        ),
      ],
    );
  }
}
