enum ExamStatus { done, pending }

class Exam {
  final int id;
  final String title;
  final int courseId;
  final ExamStatus status;

  Exam({
    required this.id,
    required this.title,
    required this.courseId,
    required this.status,
  });

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'],
      title: map['title'],
      courseId: map['course_id'],
      status: ExamStatus.values.byName(map['status']),
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
