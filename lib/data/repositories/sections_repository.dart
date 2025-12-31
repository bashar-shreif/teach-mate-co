import 'package:sqflite/sqflite.dart';
import '../../models/section.dart';

class SectionsRepository {
  final Database db;

  SectionsRepository(this.db);

  Future<List<Section>> getAll() async {
    final result = await db.query('sections');
    return result.map((row) => Section.fromMap(row)).toList();
  }

  Future<int> insert(Section section) async {
    return await db.insert('sections', section.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('sections', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Section section) async {
    await db.update(
      'sections',
      section.toMap(),
      where: 'id = ?',
      whereArgs: [section.id],
    );
  }

  Future<List<Section>> getByCourseId(int courseId) async {
    final result = await db.query(
      'sections',
      where: 'course_id = ?',
      whereArgs: [courseId],
    );
    return result.map((row) => Section.fromMap(row)).toList();
  }

  Future<int> getCount() async {
    final result = await db.query('sections');
    return result.toList().length;
  }
}
