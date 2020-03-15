import 'dart:ui';

class SubjectData {
  final int id;
  final String title;
  final String teacher;
  final Color color;
  final String year;

  SubjectData({this.id, this.title, this.teacher, this.color, this.year});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'teacher': teacher,
      'color': color.value,
      'year': year,
    };
  }
}
