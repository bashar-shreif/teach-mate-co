enum QuizStatus { done, pending }

class Quiz {
  final int id;
  final String title;
  final int courseId;
  final QuizStatus status;

  Quiz({
    required this.id,
    required this.title,
    required this.courseId,
    required this.status,
  });

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      title: map['title'],
      courseId: map['course_id'],
      status: QuizStatus.values.byName(map['status']),
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
