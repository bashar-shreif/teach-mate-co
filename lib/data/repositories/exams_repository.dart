import 'package:sqflite/sqflite.dart';
import '../../models/exam.dart';

class ExamsRepository {
  final Database db;

  ExamsRepository(this.db);

  Future<List<Exam>> getAll() async {
    final result = await db.query('exams');
    return result.map((row) => Exam.fromMap(row)).toList();
  }

  Future<int> insert(Exam exam) async {
    return await db.insert('exams', exam.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('exams', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Exam exam) async {
    await db.update(
      'exams',
      exam.toMap(),
      where: 'id = ?',
      whereArgs: [exam.id],
    );
  }

  Future<List<Exam>> getByCourseId(int courseId) async {
    final result = await db.query(
      'exams',
      where: 'course_id = ?',
      whereArgs: [courseId],
    );
    return result.map((row) => Exam.fromMap(row)).toList();
  }

  Future<int> getCount() async {
    final result = await db.query('exams');
    return result.toList().length;
  }
}
