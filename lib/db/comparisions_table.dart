import 'package:f1_stats_app/db/db_wrapper.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class ComparisionsTable {
  static const String tableName = 'comparisions';

  static const String columnId = '_id';
  static const String year = 'year';
  static const String driverId1 = 'driver_id_1';
  static const String driverId2 = 'driver_id_2';
  static const String driverName1 = 'driver_name_1';
  static const String driverName2 = 'driver_name_2';
  static const String lastViewTimestamp = 'last_view_timestamp';
  static const String favorite = 'favorite';

  static const allColumns = [
    columnId,
    year,
    driverId1,
    driverId2,
    driverName1,
    driverName2,
    lastViewTimestamp,
    favorite
  ];

  Database db = locator<DbWrapper>().database;

  static Map<String, dynamic> toMap(DriverComparision data, int timestamp) => {
        year: data.year,
        driverId1: data.driverId1,
        driverId2: data.driverId2,
        driverName1: data.driverName1,
        driverName2: data.driverName2,
        lastViewTimestamp: timestamp
      };

  static DriverComparision fromMap(Map<String, dynamic> map) =>
      DriverComparision(map[year], map[driverId1], map[driverId2], map[driverName1], map[driverName2]);

  static Future<void> createTable(Database db, int version) async {
    await db.execute('''
      create table $tableName ( 
        $columnId integer primary key autoincrement, 
        $year integer, 
        $driverId1 text not null,
        $driverId2 text not null,
        $driverName1 text not null,
        $driverName2 text not null,
        $lastViewTimestamp integer,
        $favorite integer )
      ''');
  }

  Future<int> insertComparision(DriverComparision data, int timestamp) async {
    final comparisionId = await _getComparisionId(data);
    var columnsMap = toMap(data, timestamp);
    return await insertOrUpdateComparision(comparisionId, columnsMap);
  }

  Future<int> insertFavorite(DriverComparision data, int timestamp, bool isFavorite) async {
    final comparisionId = await _getComparisionId(data);
    var columnsMap = toMap(data, timestamp);
    columnsMap[favorite] = isFavorite ? 1 : 0;
    return await insertOrUpdateComparision(comparisionId, columnsMap);
  }

  Future<int> insertOrUpdateComparision(int comparisionId, Map<String, dynamic> columnsMap) async {
    if (comparisionId != null) {
      return await db.update(
          tableName, columnsMap, where: '$columnId = ?', whereArgs: [comparisionId]);
    } else {
      return await db.insert(tableName, columnsMap);
    }
  }

  Future<bool> isFavorite(DriverComparision data) async {
    final comparisionId = await _getComparisionId(data);
    List<Map<String, dynamic>> result = await db.query(tableName, columns: [favorite], where: '$columnId = ?', whereArgs: [comparisionId]);

    return result.first[favorite] == 1;
  }

  Future<int> _getComparisionId(DriverComparision driverComparision) async {
    List<Map<String, dynamic>> result = await db.query(tableName,
        columns: allColumns,
        where: '$year = ? AND ($driverId1 = ? OR $driverId1 = ?) AND ($driverId2 = ? OR $driverId2 = ?)',
        whereArgs: [
          driverComparision.year,
          driverComparision.driverId1,
          driverComparision.driverId2,
          driverComparision.driverId1,
          driverComparision.driverId2
        ]);

    return result.isNotEmpty ? result.first[columnId] : null;
  }

  Future<List<DriverComparision>> getRecentComparisions() async {
    List<Map<String, dynamic>> result =
    await db.query(tableName, columns: allColumns, orderBy: '$lastViewTimestamp DESC', limit: 5);

    return result.map((resultMap) => fromMap(resultMap)).toList();
  }

  Future<List<DriverComparision>> getFavoriteComparisions() async {
    List<Map<String, dynamic>> result =
    await db.query(tableName, columns: allColumns, orderBy: '$lastViewTimestamp DESC', where: '$favorite = 1');

    return result.map((resultMap) => fromMap(resultMap)).toList();
  }
}
