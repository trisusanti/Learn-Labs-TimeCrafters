import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tubes1/models/task.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";
  static Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    print("initDb function called");
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    String _path = join(await getDatabasesPath(), 'task.db');

    return await openDatabase(
      _path,
      version: _version,
      onCreate: (db, version) {
        print("creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, date STRING, "
          "start_time STRING, end_time STRING, "
          "remind INTEGER, repeat STRING, "
          "color INTEGER, "
          "is_completed INTEGER DEFAULT 0)",
        );
      },
    );
  }

  static Future<int> insert(Task? task) async {
    final db = await database;
    print("insert function called");
    var taskData = task!.toJson();
    print("task: $taskData");

    return await db.insert(_tableName, taskData) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName);
      print("query function calleds");
      print("maps: $maps");
      return maps;
    } catch (e) {
      // Print the exception for debugging
      print("Exception in database query: $e");
      throw e;
    }
  }

  static delete(Task task) async {
    final db = await database;

    await db.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    final db = await database;
    return await db!.rawUpdate('''
    UPDATE tasks
    SET is_completed = ?
    WHERE id =?
''', [1, id]);
  }
}
