import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Widget _toggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(visible: _openDrawer, child: Text("ปิด", style: TextStyle(fontSize: 16))),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
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
            widget.onPressed();
          },
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
        Text("เพิ่มงานใหม่", style: TextStyle(fontSize: 16)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
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
        Text("เพิ่มคลิปเสียง", style: TextStyle(fontSize: 16)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
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
        Text("เพิ่มรูปภาพ", style: TextStyle(fontSize: 16)),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: widget.backgroundColor,
          child: Icon(Icons.image, color: widget.iconColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
