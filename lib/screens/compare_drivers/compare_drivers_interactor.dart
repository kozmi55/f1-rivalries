import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';

class CompareDriversInteractor {
  Future<CompareDriversViewState> getDriverResults(int year, String driver1Id, String driver2Id) async {
    await Future.delayed(Duration(seconds: 2));

    return CompareDriversViewState(_staticDriverResults1(), _staticDriverResults2());
  }

  DriverResults _staticDriverResults1() {
    return DriverResults('Sebastian Vettel', 2, 225, 18.3, 5, 10, 15, 9);
  }

  DriverResults _staticDriverResults2() {
    return DriverResults('Lewis Hamilton', 1, 270, 21.3, 6, 12, 14, 11);
  }
}
