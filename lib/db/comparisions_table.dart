import 'package:f1_stats_app/db/db_wrapper.dart';
import 'package:f1_stats_app/screens/choose_year/recent_comparision_view_state.dart';
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

  static const allColumns = [columnId, year, driverId1, driverId2, driverName1, driverName2, lastViewTimestamp];

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
        $lastViewTimestamp integer )
      ''');
  }

  Future<int> insertComparision(DriverComparision data, int timestamp) async {
    final comparisionId = await _getComparisionId(data);
    if (comparisionId != null) {
      return await db.update(tableName, toMap(data, timestamp), where: '$columnId = ?', whereArgs: [comparisionId]);
    } else {
      return await db.insert(tableName, toMap(data, timestamp));
    }
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
        await db.query(tableName, columns: allColumns, orderBy: '$lastViewTimestamp DESC', limit: 10);

    return result.map((resultMap) => fromMap(resultMap)).toList();
  }
}
