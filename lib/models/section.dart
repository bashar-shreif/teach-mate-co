class Section {
  int? id;
  final String name;
  final int courseId;

  Section({this.id, required this.name, required this.courseId});

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'],
      name: map['name'],
      courseId: map['course_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'course_id': courseId};
  }
}
