import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/material.dart';

import 'AssignmentAttachmentData.dart';

class AssignmentData {
  final int id;
  final String title;
  final String desc;
  final MaterialColor color;
  final SubjectData subject;
  final DateTime timestamp;
  final DateTime dueDate;
  final List<AssignmentAttachmentData> attachments;

  AssignmentData(
      {this.id,
      this.title,
      this.desc,
      this.color,
      this.subject,
      this.timestamp,
      this.dueDate,
      this.attachments});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'color': color.value,
      'subject': subject.id,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'duedate': dueDate.millisecondsSinceEpoch,
      'attachments': attachments,
    };
  }
}
