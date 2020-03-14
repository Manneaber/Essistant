class SubjectData {
  final int id;
  final String title;
  final String teacher;
  final String year;

  SubjectData({this.id, this.title, this.teacher, this.year});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'teacher': teacher,
      'year': year,
    };
  }
}
