import 'package:sqflite/sqflite.dart';
import '../../models/assignment.dart';

class AssignmentsRepository {
  final Database db;

  AssignmentsRepository(this.db);

  Future<List<Assignment>> getAll() async {
    final result = await db.query('assignments');
    return result.map((row) => Assignment.fromMap(row)).toList();
  }

  Future<int> insert(Assignment assignment) async {
    return await db.insert('assignments', assignment.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('assignments', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Assignment assignment) async {
    await db.update(
      'assignments',
      assignment.toMap(),
      where: 'id = ?',
      whereArgs: [assignment.id],
    );
  }

  Future<List<Assignment>> getByCourseId(int courseId) async {
    final result = await db.query(
      'assignments',
      where: 'course_id = ?',
      whereArgs: [courseId],
    );
    return result.map((row) => Assignment.fromMap(row)).toList();
  }

  Future<int> getCount() async {
    final result = await db.query('assignments');
    return result.toList().length;
  }
}
