import 'AssignmentAttachmentType.dart';

class AssignmentAttachmentData {
  final int id;
  final int assid;
  final String url;
  final AssignmentAttachmentType type;

  AssignmentAttachmentData({this.id, this.assid, this.url, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assid': assid,
      'url': url,
      'type': type.index,
    };
  }
}
