class SubjectData {
  final int id;
  final String title;
  final String teacher;

  SubjectData({this.id, this.title, this.teacher});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'teacher': teacher,
    };
  }
}
