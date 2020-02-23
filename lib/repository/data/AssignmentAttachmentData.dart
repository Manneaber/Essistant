import 'AssignmentAttachmentType.dart';

class AssignmentAttachmentData {
  final String id;
  final int assid;
  final String title;
  final AssignmentAttachmentType type;

  AssignmentAttachmentData({this.id, this.assid, this.title, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assid': assid,
      'title': title,
      'type': type.index,
    };
  }
}
