// A widget that displays the picture taken by the user.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DisplayPictureRoute extends StatelessWidget {
  final String title;
  final String imagePath;

  const DisplayPictureRoute(
      {Key key, this.title = "รูปภาพ", @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: PhotoView(
        imageProvider: FileImage(File(imagePath)),
        minScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
