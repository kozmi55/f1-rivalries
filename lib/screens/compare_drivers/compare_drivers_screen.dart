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

  CompareDriversInteractor _interactor = locator<CompareDriversInteractor>();

  bool _isFavorite;

  final positiveColor = Color.fromARGB(31, 0, 255, 0);
  final negativeColor = Color.fromARGB(31, 255, 0, 0);

  @override
  Widget build(BuildContext context) {
    if (_compareDriversViewStateFuture == null) {
      _compareDriversViewStateFuture = _interactor.getDriverResults(widget.year, widget.driver1Id, widget.driver2Id);
    }

    return FutureBuilder(
      future: _compareDriversViewStateFuture,
      builder: (context, AsyncSnapshot<CompareDriversViewState> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Theme.of(context).scaffoldBackgroundColor, child: LoadingIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return _error();
        } else {
          if (_isFavorite == null) {
            _isFavorite = snapshot.data.isFavorite;
          }
          return _compareDriversBody(snapshot.data);
        }
      },
    );
  }

  IconButton getFavoriteButton() {
    if (_isFavorite) {
      return IconButton(
        icon: Icon(Icons.star),
        onPressed: () => removeFromFavorites(),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.star_border),
        onPressed: () => addToFavorites(),
      );
    }
  }

  void removeFromFavorites() {
    _interactor.removeFromFavorites();
    setState(() {
      _isFavorite = false;
    });
  }

  void addToFavorites() {
    _interactor.addToFavorites();
    setState(() {
      _isFavorite = true;
    });
  }

  Widget _error() {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: Text("Failed to load"));
  }

  Widget _compareDriversBody(CompareDriversViewState data) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year} F1 World Championship'),
        actions: [getFavoriteButton()],
      ),
      body: Column(children: [
        CompareDriverRow(
            description: '',
            driverData1: data.driverResults1.name,
            driverData2: data.driverResults2.name,
            driverDataStyle: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
        CompareDriverRow(
            description: 'Ranking',
            driverData1: '${data.driverResults1.championshipPosition}.',
            driverData2: '${data.driverResults2.championshipPosition}.'),
        CompareDriverRow(
            description: 'Points',
            driverData1: '${_formatValue(data.driverResults1.championshipPoints)} pts.',
            driverData2: '${_formatValue(data.driverResults2.championshipPoints)} pts.'),
        CompareDriverRow(
            description: 'Average points per race',
            driverData1: '${_formatValue(data.driverResults1.pointsPerRace)} pts.',
            driverData2: '${_formatValue(data.driverResults2.pointsPerRace)} pts.'),
        CompareDriverRow(
            description: 'Wins',
            driverData1: '${data.driverResults1.wins}',
            driverData2: '${data.driverResults2.wins}',
            driver1Color: _getBackgroundColor(data.driverResults1.wins, data.driverResults2.wins),
            driver2Color: _getBackgroundColor(data.driverResults2.wins, data.driverResults1.wins)),
        CompareDriverRow(
            description: 'Podiums',
            driverData1: '${data.driverResults1.podiums}',
            driverData2: '${data.driverResults2.podiums}',
            driver1Color: _getBackgroundColor(data.driverResults1.podiums, data.driverResults2.podiums),
            driver2Color: _getBackgroundColor(data.driverResults2.podiums, data.driverResults1.podiums)),
        CompareDriverRow(
            description: 'Points finishes',
            driverData1: '${data.driverResults1.pointsFinishes}',
            driverData2: '${data.driverResults2.pointsFinishes}',
            driver1Color: _getBackgroundColor(data.driverResults1.pointsFinishes, data.driverResults2.pointsFinishes),
            driver2Color: _getBackgroundColor(data.driverResults2.pointsFinishes, data.driverResults1.pointsFinishes)),
        CompareDriverRow(
            description: 'Head to head',
            driverData1: '${data.driverResults1.headToHead}',
            driverData2: '${data.driverResults2.headToHead}',
            driver1Color: _getBackgroundColor(data.driverResults1.headToHead, data.driverResults2.headToHead),
            driver2Color: _getBackgroundColor(data.driverResults2.headToHead, data.driverResults1.headToHead))
      ]),
    );
  }

  Color _getBackgroundColor(int value, int otherValue) {
    if (value == otherValue) {
      return Colors.transparent;
    } else if (value > otherValue) {
      return positiveColor;
    } else {
      return negativeColor;
    }
  }

  String _formatValue(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }
}
