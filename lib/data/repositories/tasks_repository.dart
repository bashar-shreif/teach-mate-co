import 'package:sqflite/sqflite.dart';
import '../../models/task.dart';

class TasksRepository {
  final Database db;

  TasksRepository(this.db);

  Future<List<Task>> getAll() async {
    final result = await db.query('tasks');
    return result.map((row) => Task.fromMap(row)).toList();
  }

  Future<int> insert(Task task) async {
    return await db.insert('tasks', task.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(Task task) async {
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> getByCategory(String category) async {
    final result = await db.query(
      'tasks',
      where: 'category = ?',
      whereArgs: [category],
    );
    return result.map((row) => Task.fromMap(row)).toList();
  }

  Future<int> getByStatus(String status) async {
    final result = await db.query(
      'tasks',
      where: 'status = ?',
      whereArgs: [status],
    );
    return result.toList().length;
  }
}
