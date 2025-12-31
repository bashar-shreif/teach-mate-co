import 'package:sqflite/sqflite.dart';
import '../../models/user.dart';

class UsersRepository {
  final Database db;

  UsersRepository(this.db);

  Future<List<User>> getAll() async {
    final result = await db.query('users');
    return result.map((row) => User.fromMap(row)).toList();
  }

  Future<int> insert(User user) async {
    return await db.insert('users', user.toMap());
  }

  Future<void> delete(int id) async {
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(User user) async {
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<User?> getByEmail(String email) async {
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  Future<int> getCount() async {
    final result = await db.query('users');
    return result.toList().length;
  }
}
