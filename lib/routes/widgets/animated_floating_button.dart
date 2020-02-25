import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final void Function() onPressed;
  final Color backgroundColor;

  const AnimatedFloatingButton({
    Key key,
    @required this.onPressed,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton> {
  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      onPressed: widget.onPressed,
      backgroundColor: widget.backgroundColor,
      
    );
  }
}
