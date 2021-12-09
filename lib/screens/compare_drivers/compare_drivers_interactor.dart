import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/network/entity/drivers_response.dart';
import 'package:f1_stats_app/network/entity/drivers_results_response.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class CompareDriversInteractor {
  final DriversApi _driversApi = locator<DriversApi>();

  DriverComparision _currentComparision;

  Future<CompareDriversViewState> getDriverResults(int year, String driver1Id, String driver2Id) async {
    final driverResults1 = await _driversApi.getDriverResultsForYear(year, driver1Id);
    final driverResults2 = await _driversApi.getDriverResultsForYear(year, driver2Id);

    // Probably this could be passed from the previous screen,
    // but since we are caching the response this will always come from the cache.
    final response = await _driversApi.getDriversForYear(year);
    final driversResponse = DriversResponse.fromJson(response.data);

    final driverStanding1 =
        driversResponse.driverStandings.firstWhere((element) => element.driverEntity.driverId == driver1Id);

    final driverStanding2 =
        driversResponse.driverStandings.firstWhere((element) => element.driverEntity.driverId == driver2Id);

    final headToHead = _getHeadToHead(driverResults1, driverResults2);

    var driver1 = _mapResults(driverResults1, driverStanding1, headToHead[0]);
    var driver2 = _mapResults(driverResults2, driverStanding2, headToHead[1]);

    _currentComparision = DriverComparision(year, driver1Id, driver2Id, driver1.name, driver2.name);

    return CompareDriversViewState(driver1, driver2, false);
  }

  DriverResults _mapResults(DriverResultsResponse response, DriverStanding driversStanding, int headToHead) {
    final raceTable = response.mrData.raceTable;

    return DriverResults(
        _getName(driversStanding),
        _getChampionshipPosition(driversStanding),
        _getTotalPoints(driversStanding),
        _getAveragePoints(driversStanding, raceTable),
        _getWins(raceTable),
        _getPodiums(raceTable),
        _getPointsFinishes(raceTable),
        headToHead);
  }

  String _getName(DriverStanding driverStanding) {
    final driver = driverStanding.driverEntity;
    return '${driver.givenName} ${driver.familyName}';
  }

  int _getChampionshipPosition(DriverStanding driversStanding) {
    return int.parse(driversStanding.position);
  }

  double _getTotalPoints(DriverStanding driversStanding) {
    return double.parse(driversStanding.points);
  }

  double _getAveragePoints(DriverStanding driverStanding, RaceTable raceTable) {
    return _getTotalPoints(driverStanding) / raceTable.races.length;
  }

  int _getWins(RaceTable raceTable) {
    return raceTable.races.map((race) => race.results[0].position).where((element) => element == "1").length;
  }

  int _getPodiums(RaceTable raceTable) {
    return raceTable.races
        .map((race) => race.results[0].position)
        .where((element) => _isPodiumPosition(element))
        .length;
  }

  bool _isPodiumPosition(String element) => element == "1" || element == "2" || element == "3";

  int _getPointsFinishes(RaceTable raceTable) {
    return raceTable.races
        .map((race) => race.results[0].points)
        .where((element) => element != "0")
        .length;
  }

  List<int> _getHeadToHead(DriverResultsResponse driverResults1, DriverResultsResponse driverResults2) {
    Map<String, int> driver1PositionsByRound = Map();
    driverResults1.mrData.raceTable.races.forEach((race) {
      driver1PositionsByRound[race.round] = int.parse(race.results[0].position);
    });

    var driver1Better = 0;
    var driver2Better = 0;

    driverResults2.mrData.raceTable.races.forEach((race) {
      if (driver1PositionsByRound.containsKey(race.round)) {
        final driver1Pos = driver1PositionsByRound[race.round];
        final driver2Pos = int.parse(race.results[0].position);
        if (driver1Pos < driver2Pos)
          driver1Better++;
        else
          driver2Better++;
      }
    });

    return [driver1Better, driver2Better];
  }
}
