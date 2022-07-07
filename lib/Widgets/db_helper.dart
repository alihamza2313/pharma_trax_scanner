import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const databaseName = "pharam_trax_scanner.db";
  static const databaseVersion = 1;

  // Table #1 name "products" has list of all items
  static const table1 = "products";

  static const table1ColumnId = "id";
  static const table1ColumnPlain1 = "plain1";
  static const table1ColumnCline3 = "cline3";
  static const table1ColumnSline4 = "sline4";
  static const table1ColumnVersion = "version";

  // Table #2 name "scanned_products" has list of all items
  static const table2 = "scanned_products";

  static const table2ColumnId = "id";
  static const table2ColumnBarcodeType = "barcode_type";
  static const table2ColumnDate = "date";

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

  // ignore: non_constant_identifier_names
  Future _onCreate(Database db, int Version) async {
    await db.execute('''
      CREATE TABLE $table1 (
        $table1ColumnId TEXT PRIMARY KEY,
        $table1ColumnPlain1 TEXT NOT NULL,
        $table1ColumnCline3 TEXT NOT NULL,
        $table1ColumnSline4 REAL NOT NULL,
        $table1ColumnVersion TEXT NOT NULL 
      )''');
    await db.execute('''
      CREATE TABLE $table2 (
        $table2ColumnId TEXT NOT NULL,
        $table2ColumnBarcodeType TEXT NOT NULL,
        $table2ColumnDate TEXT NOT NULL
      )''');
  }

  // Functiuons to perform some functionality with database table #1 name "products"
  Future<int?> insertTable1(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table1, row);
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
