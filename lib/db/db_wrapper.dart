import 'package:f1_stats_app/db/comparisions_table.dart';
import 'package:sqflite/sqflite.dart';

List<OnDatabaseCreateFn> _creators = [ComparisionsTable.createTable];

class DbWrapper {
  static const _dbVersion = 1;
  static const _dbName = 'f1_stats.db';

  Database _db;

  Database get database {
    if (_db == null) throw StateError('Database has not been initialized!');
    return _db;
  }

  Future<void> initDatabase() async {
    _db = await openDatabase(_dbName, version: _dbVersion, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    _creators.forEach((creator) => creator(db, version));
  }
}
