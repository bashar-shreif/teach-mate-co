class Course {
  int? id;
  final String title;
  final String code;

  Course({this.id, required this.title, required this.code});

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(id: map['id'], title: map['title'], code: map['code']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'code': code};
  }
}
