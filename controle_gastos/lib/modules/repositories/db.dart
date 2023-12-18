import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/conta_db.dart';

const tableName = 'quotes';


/// This class instantiates a Database provider for the [Contas] and [ContasDB] classes
class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  Future<Database> get database async => _database ?? await _initDB();

  /// This method creates the database
  Future<Database> _initDB() async {
    
    return openDatabase(
      join(await getDatabasesPath(), 'contas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id TEXT PRIMARY KEY,'
          'price REAL,'
          'description TEXT,'
          'title TEXT,'
          'time TEXT)',
        );
      },
      version: 1,
    );
  }

  /// This method get all contas from the Database as a list of ContasDB
  /// 
  /// Parameters:
  /// 
  ///   None
  /// 
  /// Returns:
  /// 
  ///   Future of List of ContaDB, after resolving it will be a List of ContaDB
  Future<List<ContaDB>> getAllContas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) => ContaDB.fromMap(maps[index]));
  }

  /// This method inserts a ContaDB in the Database asynchronously
  /// 
  /// Parameters:
  /// 
  ///   [conta]: An instance of [ContaDB] to be inserted in the Database. No verifications are made at this point
  /// 
  /// Returns:
  ///   [Future<void>]
  Future<void> insertConta(ContaDB conta) async {
    final db = await database;
    await db.insert(
      tableName,
      conta.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  /// This method deletes a ContaDB instance representation on the database based on the id of the ContaDB
  /// 
  /// Parameters:
  /// 
  /// [conta], an instance of [ContaDB] in the database
  /// 
  /// Returns:
  /// 
  ///   [Future<void>]
  Future<void> deleteConta(ContaDB conta) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [conta.id]);
  }
}
