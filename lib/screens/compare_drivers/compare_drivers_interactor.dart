import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/network/entity/drivers_response.dart';
import 'package:f1_stats_app/network/entity/drivers_results_response.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class CompareDriversInteractor {
  DriversApi _driversApi = locator<DriversApi>();

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

    return CompareDriversViewState(
        _mapResults(driverResults1, driverStanding1), _mapResults(driverResults2, driverStanding2));
  }

  DriverResults _mapResults(DriverResultsResponse response, DriverStanding driversStanding) {
    final raceTable = response.mrData.raceTable;

    return DriverResults(
        _getName(raceTable),
        _getChampionshipPosition(driversStanding),
        _getTotalPoints(driversStanding),
        _getAveragePoints(driversStanding, raceTable),
        _getWins(raceTable),
        _getPodiums(raceTable),
        _getPointsFinishes(raceTable),
        0); // TODO Head to head
  }

  String _getName(RaceTable raceTable) {
    final driver = raceTable.races[0].results[0].driver;
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
    return raceTable.races.map((race) => race.results[0].points).where((element) => element != "0").length;
  }
}
