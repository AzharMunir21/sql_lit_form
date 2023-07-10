import 'dart:io' show Directory;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const dbName = "MyDatabase.db";
  static const tableName = "tableName";
  static const id = "id";
  static const version = 1;
  static const formField = "formField";
  static const gender = "gender";
  static const terms = "terms";
  static const countryName = "countryName";

  Database? _database;

  static final DatabaseHelper instance = DatabaseHelper();
  Future<Database?> get database async {
    _database ??= await initDb();
    return _database;
  }

  initDb() async {
    final directory = await getApplicationDocumentsDirectory();
    // await getDatabasesPath();
    String path = join(directory.path, dbName);
    return openDatabase(path, version: version, onCreate: onCreate);
  }

  onCreate(Database db, int version) async {
    await db.execute('''create table $tableName 
    ($id integer primary key autoincrement,  
    $formField Text Not Null,
    $gender Text Not Null,
    $terms Text Not Null,
    $countryName Text Not Null)''');
  }

  readRecord() async {
    Database? db = await database;

    return await db?.query(tableName);
  }

  insertRecord(Map<String, dynamic> row) async {
    Database? db = await database;
    return db?.insert(tableName, row);
  }

  updateRecord(Map<String, dynamic> row) async {
    Database? db = await database;
    int ids = row[id];
    return await db!.update(tableName, row, where: "$id= ?", whereArgs: [ids]);
  }

  deleteRecord(int ids) async {
    Database? db = await database;
    return db?.delete(tableName, where: '$id = ?', whereArgs: [ids]);
  }
}
