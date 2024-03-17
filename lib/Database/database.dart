import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  static Database? _database;
  static const String temperatureTable = 'temperature';
  static const String phLevelTable = 'phlevel';
  static const String feederTable = 'feeder';
  static const String feederHistoryTable = 'feederhistory';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'aquaponia.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    bool tableTemperatureExists =
        await _doesTableExist(db, DatabaseConfig.temperatureTable);

    if (!tableTemperatureExists) {
      await db.execute('''
        CREATE TABLE $temperatureTable(
          id INTEGER PRIMARY KEY,
          temperature_value INTEGER,
          create_at DATETIME
        )
      ''');
    }

    bool tablePhLevelExists =
        await _doesTableExist(db, DatabaseConfig.phLevelTable);

    if (!tablePhLevelExists) {
      await db.execute('''
        CREATE TABLE $phLevelTable(
          id INTEGER PRIMARY KEY,
          ph_level_value INTEGER,
          create_at DATETIME
        )
      ''');
    }

    bool tableFeederExists =
        await _doesTableExist(db, DatabaseConfig.feederTable);

    if (!tableFeederExists) {
      await db.execute('''
        CREATE TABLE $feederTable(
          id INTEGER PRIMARY KEY,
          time TEXT,
          status INTEGER,
          date DATETIME
        )
      ''');
    }

    bool tableFeederHistoryExists =
        await _doesTableExist(db, DatabaseConfig.feederHistoryTable);

    if (!tableFeederHistoryExists) {
      await db.execute('''
        CREATE TABLE $feederHistoryTable(
          id INTEGER PRIMARY KEY,
          time TEXT,
          status INTEGER,
          date DATETIME
        )
      ''');
    }
  }

  Future<bool> _doesTableExist(Database db, String tableName) async {
    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");

    return result.isNotEmpty;
  }

  Future<int> insertData(Map<String, dynamic> row, table) async {
    Database db = await database;

    if (table == temperatureTable) {
      return await db.insert(temperatureTable, row);
    }

    if (table == phLevelTable) {
      return await db.insert(phLevelTable, row);
    }

    if (table == feederHistoryTable) {
      return await db.insert(feederHistoryTable, row);
    }

    return await db.insert(feederTable, row);
  }

  Future<List<Map<String, dynamic>>> fetchAllData(String table) async {
    Database db = await database;

    if (table == phLevelTable) {
      return await db.query(phLevelTable);
    }

    if (table == temperatureTable) {
      return await db.query(temperatureTable, orderBy: 'create_at DESC');
    }

    if (table == feederHistoryTable) {
      return await db.query(feederHistoryTable, orderBy: 'date DESC');
    }

    return await db.query(feederTable);
  }

  Future<List<Map<String, dynamic>>> getLatestPHLevel(String table) async {
    Database db = await database;

    if (table == temperatureTable) {
      return await db.query(
        temperatureTable,
        orderBy: 'create_at DESC',
        limit: 1,
      );
    }

    if (table == feederHistoryTable) {
      return await db.query(
        feederHistoryTable,
        orderBy: 'date DESC',
        limit: 1,
      );
    }

    if (table == feederTable) {
      return await db.query(
        feederTable,
        orderBy: 'date DESC',
        limit: 1,
      );
    }

    return await db.query(
      phLevelTable,
      orderBy: 'create_at DESC',
      limit: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getDaysRecord(
      String table, int days) async {
    Database db = await database;
    DateTime thirtyDaysAgo = DateTime.now().subtract(Duration(days: days));

    String dateColumn = 'create_at';
    if (table == feederHistoryTable || table == feederTable) {
      dateColumn = 'date';
    }

    List<Map<String, dynamic>> result = await db.query(table,
        orderBy: '$dateColumn DESC',
        where: '$dateColumn > ?',
        whereArgs: [thirtyDaysAgo.toIso8601String()]);

    return result;
  }

  Future<void> updateFeederStatus(int id, bool newStatus) async {
    Database db = await database;

    await db.update(
      feederTable,
      {'status': newStatus ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteFeederSchedule(int id) async {
    Database db = await database;
    await db.delete(feederTable, where: 'id = ?', whereArgs: [id]);
  }
}
