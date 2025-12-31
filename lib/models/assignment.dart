enum AssignmentStatus { done, pending }

class Assignment {
  final int id;
  final String title;
  final int courseId;
  final AssignmentStatus status;

  Assignment({
    required this.id,
    required this.title,
    required this.courseId,
    required this.status,
  });

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'],
      title: map['title'],
      courseId: map['course_id'],
      status: AssignmentStatus.values.byName(map['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'course_id': courseId,
      'status': status.name,
    };
  }
}
