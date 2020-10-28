import 'package:f1_stats_app/screens/compare_drivers/compare_driver_row.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompareDriversScreen extends StatefulWidget {
  final String driver1Id;
  final String driver2Id;
  final int year;

  CompareDriversScreen({Key key, this.year, this.driver1Id, this.driver2Id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompareDriversScreenState();
}

class _CompareDriversScreenState extends State<CompareDriversScreen> {
  Future<CompareDriversViewState> _compareDriversViewStateFuture;

  CompareDriversInteractor get _interactor => locator<CompareDriversInteractor>();

  @override
  Widget build(BuildContext context) {
    if (_compareDriversViewStateFuture == null) {
      _compareDriversViewStateFuture = _interactor.getDriverResults(widget.year, widget.driver1Id, widget.driver2Id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year} F1 World Championship'),
      ),
      body: FutureBuilder(
        future: _compareDriversViewStateFuture,
        builder: (context, AsyncSnapshot<CompareDriversViewState> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Theme.of(context).scaffoldBackgroundColor, child: LoadingIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return _error();
          } else {
            return _compareDriversBody(snapshot.data);
          }
        },
      ),
    );
  }

  Widget _error() {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: Text("Failed to load"));
  }

  Widget _compareDriversBody(CompareDriversViewState data) {
    return Column(children: [
      CompareDriverRow(
          description: 'Name', driverData1: data.driverResults1.name, driverData2: data.driverResults2.name),
      CompareDriverRow(
          description: 'Ranking',
          driverData1: '${data.driverResults1.championshipPosition}.',
          driverData2: '${data.driverResults2.championshipPosition}.'),
      CompareDriverRow(
          description: 'Points',
          driverData1: '${data.driverResults1.championshipPoints} pts.',
          driverData2: '${data.driverResults2.championshipPoints} pts.'),
      CompareDriverRow(
          description: 'Average points per race',
          driverData1: '${data.driverResults1.pointsPerRace} pts.',
          driverData2: '${data.driverResults2.pointsPerRace} pts.'),
      CompareDriverRow(
          description: 'Wins',
          driverData1: '${data.driverResults1.wins}',
          driverData2: '${data.driverResults2.wins}'),
      CompareDriverRow(
          description: 'Podiums',
          driverData1: '${data.driverResults1.podiums}',
          driverData2: '${data.driverResults2.podiums}'),
      CompareDriverRow(
          description: 'Points finishes',
          driverData1: '${data.driverResults1.pointsFinishes}',
          driverData2: '${data.driverResults2.pointsFinishes}'),
      CompareDriverRow(
          description: 'Head to head results',
          driverData1: '${data.driverResults1.headToHead}',
          driverData2: '${data.driverResults2.headToHead}')
    ]);
  }
}
