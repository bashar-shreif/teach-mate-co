enum TaskStatus { done, pending }

enum TaskCategory { exams, quizzes, assignments, sections, courses }

class Task {
  int? id;
  final String description;
  final TaskStatus status;
  final DateTime dueDate;
  final TaskCategory category;

  Task({
    this.id,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.category,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: map['description'],
      status: TaskStatus.values.byName(map['status']),
      dueDate: DateTime.parse(map['due_date']),
      category: TaskCategory.values.byName(map['category']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'status': status.name,
      'due_date': dueDate.toIso8601String(),
      'category': category.name,
    };
  }
}
