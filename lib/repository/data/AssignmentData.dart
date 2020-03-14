import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/material.dart';

import 'AssignmentAttachmentData.dart';

class AssignmentData {
  final int id;
  final String title;
  final String desc;
  final Color color;
  final SubjectData subject;
  final int timestamp;
  final int dueDate;
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
      'timestamp': timestamp,
      'duedate': dueDate,
      'attachments': attachments,
    };
  }
}
