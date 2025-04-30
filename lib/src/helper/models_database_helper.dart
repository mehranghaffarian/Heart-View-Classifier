import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ModelsDatabaseHelper {
  static const _databaseName = 'models_database.db';
  static const table = 'MODELS';

  // make this a singleton class
  ModelsDatabaseHelper._privateConstructor();

  static final ModelsDatabaseHelper instance =
      ModelsDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database == null || !_database!.isOpen) {
      await _initDatabase();
    }
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    _database = await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE MODELS(name VARCHAR(50), summary VARCHAR(200), description VARCHAR(500), inputSize VARCHAR(20), accuracy Double, isSaved INTEGER, PRIMARY KEY (name));''');
  }

  Future<int> insert(DLModel model) async {
    try {
      final db = await instance.database;
      final res = await db.insert(table, model.toJson());
      return res;
    } catch (_) {
      return 0;
    }
  }

  Future<int> update(DLModel model) async {
    try {
      final db = await instance.database;
      final res = await db.update(
        table,
        model.toJson(),
        where: 'name = ?', // safer syntax with '?'
        whereArgs: [model.name],
      );
      return res;
    } catch (_) {
      return 0;
    }
  }

  Future<int> delete(String modelName) async {
    try {
      final db = await instance.database;
      final res = await db.delete(
        table,
        where: "name = ?",
        whereArgs: [modelName],
      );
      return res;
    } catch (_) {
      return 0;
    }
  }

  Future<int> deleteAll() async {
    try {
      final db = await instance.database;
      final res = await db.delete(table);
      return res;
    } catch (_) {
      return 0;
    }
  }

  Future<List<DLModel>> querySavedModels() async {
    final db = await instance.database;
    final res = await db.query(
      table,
      where: 'isSaved = ?',
      whereArgs: [1],
    );
    return res.map((e) => DLModel.fromJson(e)).toList();
  }

  Future<List<DLModel>> queryAllRows() async {
    final db = await instance.database;
    final res =
        (await db.query(table)).map((e) => DLModel.fromJson(e)).toList();
    return res;
  }
}
