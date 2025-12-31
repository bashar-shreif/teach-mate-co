import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'repositories/users_repository.dart';
import 'repositories/courses_repository.dart';
import 'repositories/sections_repository.dart';
import 'repositories/exams_repository.dart';
import 'repositories/quizzes_repository.dart';
import 'repositories/assignments_repository.dart';
import 'repositories/tasks_repository.dart';

class TeachMateStorage {
  TeachMateStorage._internal();

  static final TeachMateStorage instance = TeachMateStorage._internal();

  Database? _db;

  UsersRepository? _users;
  CoursesRepository? _courses;
  SectionsRepository? _sections;
  ExamsRepository? _exams;
  QuizzesRepository? _quizzes;
  AssignmentsRepository? _assignments;
  TasksRepository? _tasks;

  Future<void> init() async {
    _db ??= await AppDatabase.instance.database;
  }

  UsersRepository get users {
    return _users ??= UsersRepository(_db!);
  }

  CoursesRepository get courses {
    return _courses ??= CoursesRepository(_db!);
  }

  SectionsRepository get sections {
    return _sections ??= SectionsRepository(_db!);
  }

  ExamsRepository get exams {
    return _exams ??= ExamsRepository(_db!);
  }

  QuizzesRepository get quizzes {
    return _quizzes ??= QuizzesRepository(_db!);
  }

  AssignmentsRepository get assignments {
    return _assignments ??= AssignmentsRepository(_db!);
  }

  TasksRepository get tasks {
    return _tasks ??= TasksRepository(_db!);
  }
}
