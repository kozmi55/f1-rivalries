import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';

class ChooseDriversInteractor {
  Future<ChooseDriversViewState> getDriversListForYear(int year) async {
    await Future.delayed(Duration(seconds: 2));
    return ChooseDriversViewState(_generateStaticData());
  }

  List<Driver> _generateStaticData() {
    final vettel = Driver('Vettel', 'Sebastian Vettel', 'Ferrari');
    final leclerc = Driver('Leclerc', 'Charles Leclerc', 'Ferrari');
    final hamilton = Driver('Hamilton', 'Lewis Hamilton', 'Mercedes');

    return [vettel, leclerc, hamilton];
  }
}
