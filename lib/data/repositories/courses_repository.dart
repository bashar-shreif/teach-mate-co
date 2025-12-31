import 'package:sqflite/sqflite.dart';
import '../../models/course.dart';

class CoursesRepository {
  final Database db;

  CoursesRepository(this.db);

  Future<List<Course>> getAll() async {
    final result = await db.query('courses');
    return result.map((row) => Course.fromMap(row)).toList();
  }

  Future<int> insert(Course course) async {
    return await db.insert('courses', course.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Course course) async {
    await db.update(
      'courses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  Future<int> getCount() async {
    final result = await db.query('courses');
    return result.toList().length;
  }
}
