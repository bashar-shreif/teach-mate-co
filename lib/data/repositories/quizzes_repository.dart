import 'package:sqflite/sqflite.dart';
import '../../models/quiz.dart';

class QuizzesRepository {
  final Database db;

  QuizzesRepository(this.db);

  Future<List<Quiz>> getAll() async {
    final result = await db.query('quizzes');
    return result.map((row) => Quiz.fromMap(row)).toList();
  }

  Future<int> insert(Quiz quiz) async {
    return await db.insert('quizzes', quiz.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('quizzes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Quiz quiz) async {
    await db.update(
      'quizzes',
      quiz.toMap(),
      where: 'id = ?',
      whereArgs: [quiz.id],
    );
  }

  Future<List<Quiz>> getByCourseId(int courseId) async {
    final result = await db.query(
      'quizzes',
      where: 'course_id = ?',
      whereArgs: [courseId],
    );
    return result.map((row) => Quiz.fromMap(row)).toList();
  }

  Future<int> getCount() async {
    final result = await db.query('quizzes');
    return result.toList().length;
  }
}
