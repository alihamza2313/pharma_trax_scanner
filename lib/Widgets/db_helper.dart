import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static String databaseName = "pharam_trax_scanner.db";
  static int databaseVersion = 1;

  // Info Table name "dbinfo" has info of data base
  static String infoTable = "dbinfo";

  static String infoTableColumnVersion = "version";
  static String infoTableColumnUpdateDate = "update_date";
  static String infoTableColumnMessage = "message";
  static String infoTableColumnStatus = "status";

  // Table #1 name "products" has list of all items
  static String table1 = "products";

  static String table1ColumnId = "id";
  static String table1ColumnPlain1 = "plain1";
  static String table1ColumnCline3 = "cline3";
  static String table1ColumnSline4 = "sline4";
  static String table1ColumnVersion = "version";
  static String table1ColumnIsModified = "is_modified";

  // Table #2 name "scanned_products" has list of all items
  static String table2 = "scanned_products";

  static String table2ColumnId = "id";
  static String table2ColumnBarcodeType = "barcode_type";
  static String table2ColumnDate = "date";

  static Database? _database;

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $infoTable (
        $infoTableColumnVersion TEXT NOT NULL,
        $infoTableColumnUpdateDate TEXT NOT NULL,
        $infoTableColumnMessage TEXT NOT NULL,
        $infoTableColumnStatus TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE $table1 (
        $table1ColumnId TEXT PRIMARY KEY,
        $table1ColumnPlain1 TEXT NOT NULL,
        $table1ColumnCline3 TEXT NOT NULL,
        $table1ColumnSline4 TEXT NOT NULL,
        $table1ColumnVersion TEXT NOT NULL,
        $table1ColumnIsModified TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE $table2 (
        $table2ColumnId TEXT NOT NULL,
        $table2ColumnBarcodeType TEXT NOT NULL,
        $table2ColumnDate TEXT NOT NULL
      )''');
  }

  // Functiuons to perform some functionality with database info table name "dbinfo"
  Future<int?> insertInfoTable(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    await db!.delete(infoTable);
    return await db.insert(infoTable, row);
  }

  Future<List<Map<String, dynamic>>> fatchInfoTable() async {
    Database? db = await instance.database;
    return await db!.query(infoTable);
  }

  // Functiuons to perform some functionality with database table #1 name "products"
  bool _check = true;
  Future<int?> insertTable1(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    if (_check) {
      deleteTable1();
      _check = false;
    }
    return await db!.insert(table1, row);
  }

  Future<List<Map<String, dynamic>>> fatchTable1() async {
    Database? db = await instance.database;
    return await db!.query(table1);
  }

  Future<void> deleteTable1() async {
    Database? db = await instance.database;
    await db!.delete(table1);
  }

  // Functiuons to perform some functionality with database table #2 name "scanned_products"
  Future<int?> insertTable2(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table2, row);
  }

  Future<List<Map<String, dynamic>>> fatchTable2() async {
    Database? db = await instance.database;
    return await db!.query(table2);
  }

  Future<void> deleteTable2() async {
    Database? db = await instance.database;
    await db!.delete(table2);
  }
}
