import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/network/entity/drivers_response.dart';
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';
import 'package:f1_stats_app/utils/service_locator.dart';

class ChooseDriversInteractor {
  DriversApi _driversApi = locator<DriversApi>();

  Future<ChooseDriversViewState> getDriversListForYear(int year) async {
    final response = await _driversApi.getDriversForYear(year);
    final driversResponse = DriversResponse.fromJson(response.data);

    return ChooseDriversViewState(
        _mapDriversResponseToViewState(driversResponse));
  }

  List<Driver> _mapDriversResponseToViewState(DriversResponse driversResponse) {
    return driversResponse.driverStandings
        .map((driverStanding) => Driver(
            driverStanding.driverEntity.driverId,
            '${driverStanding.driverEntity.givenName} ${driverStanding.driverEntity.familyName}',
            _mapConstructors(driverStanding),
            int.parse(driverStanding.position),
            driverStanding.points))
        .toList();
  }

  String _mapConstructors(DriverStanding driverStanding) {
    return driverStanding.constructors.map((constructor) => constructor.name).join(", ");
  }
}
