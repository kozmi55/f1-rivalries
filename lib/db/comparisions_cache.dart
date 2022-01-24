import 'dart:math';

import 'package:f1_stats_app/db/driver_comparision_data.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:hive/hive.dart';

const boxName = 'comparisions';
const recentsKey = 'recents';
const favoritesKey = 'favorites';

class ComparisionsCache {

  HiveInterface hive = locator<HiveInterface>();

  void insertRecentComparision(DriverComparision comparision) async {
    final data = DriverComparisionData(_getComparisionId(comparision), comparision.year, comparision.driverId1, comparision.driverId2, comparision.driverName1, comparision.driverName2, DateTime.now().millisecondsSinceEpoch);

    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(recentsKey, defaultValue: {});

    final id = _getComparisionId(comparision);
    values[id] = data;
    box.put(recentsKey, values);
  }

  Future<int> insertFavorite(DriverComparision comparision) async {
    final data = DriverComparisionData(_getComparisionId(comparision), comparision.year, comparision.driverId1, comparision.driverId2, comparision.driverName1, comparision.driverName2, DateTime.now().millisecondsSinceEpoch);

    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(favoritesKey, defaultValue: {});

    final id = _getComparisionId(comparision);
    values[id] = data;
    box.put(favoritesKey, values);
  }

  Future<int> removeFavorite(DriverComparision comparision) async {
    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(favoritesKey, defaultValue: {});

    final id = _getComparisionId(comparision);
    values.remove(id);
    box.put(favoritesKey, values);
  }

  Future<bool> isFavorite(DriverComparision comparision) async {
    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(favoritesKey, defaultValue: {});

    final id = _getComparisionId(comparision);
    return values.containsKey(id);
  }

  String _getComparisionId(DriverComparision driverComparision) {
    final higherId = max(driverComparision.driverId1.hashCode, driverComparision.driverId2.hashCode);
    final lowerId = min(driverComparision.driverId1.hashCode, driverComparision.driverId2.hashCode);

    return "${driverComparision.year}_${higherId}_${lowerId}";
  }

  Future<List<DriverComparision>> getRecentComparisions() async {
    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(recentsKey, defaultValue: {});
    final driverComparisions = new Map<String, DriverComparisionData>.from(values).values.toList();
    driverComparisions.sort((DriverComparisionData first, DriverComparisionData second) => first.timestamp > second.timestamp ? 0 : 1);

    return driverComparisions
        .take(5)
        .toList()
        .map((e) => DriverComparision(e.year, e.driverId1, e.driverId2, e.driverName1, e.driverName2))
        .toList();
  }

  Future<List<DriverComparision>> getFavoriteComparisions() async {
    final box = await hive.openBox(boxName);

    Map<dynamic, dynamic> values = box.get(favoritesKey, defaultValue: {});
    final favorites = new Map<String, DriverComparisionData>.from(values).values.toList();

    favorites.sort((DriverComparisionData first, DriverComparisionData second) => first.timestamp > second.timestamp ? 0 : 1);

    return favorites
        .map((e) => DriverComparision(e.year, e.driverId1, e.driverId2, e.driverName1, e.driverName2))
        .toList();
  }
}
