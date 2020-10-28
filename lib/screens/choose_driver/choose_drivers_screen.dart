import 'package:f1_stats_app/screens/choose_driver/choose_drivers_interactor.dart';
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';
import 'package:f1_stats_app/screens/choose_driver/driver_row.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_screen.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseDriversScreen extends StatefulWidget {
  final int year;

  ChooseDriversScreen({Key key, this.year}) : super(key: key);

  @override
  _ChooseDriversScreenState createState() => _ChooseDriversScreenState();
}

class _ChooseDriversScreenState extends State<ChooseDriversScreen> {
  Driver _selectedDriver;

  Future<ChooseDriversViewState> _chooseDriversViewStateFuture;

  ChooseDriversInteractor get _interactor => locator<ChooseDriversInteractor>();

  @override
  Widget build(BuildContext context) {
    if (_chooseDriversViewStateFuture == null) {
      _chooseDriversViewStateFuture = _interactor.getDriversListForYear(widget.year);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year} F1 World Championship'),
      ),
      body: FutureBuilder(
        future: _chooseDriversViewStateFuture,
        builder: (context, AsyncSnapshot<ChooseDriversViewState> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: LoadingIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return _error();
          } else {
            return _chooseDriversBody(snapshot.data);
          }
        },
      ),
    );
  }

  Widget _chooseDriversBody(ChooseDriversViewState data) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      separatorBuilder: (context, index) => Divider(height: 1),
      itemCount: data.drivers.length + 1, // Add one for the header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _createHeaderItem();
        } else {
          final item = data.drivers[index - 1];
          return InkWell(
              onTap: () => _selectDriver(context, item),
              child: DriverRowWidget(driver: item, selected: item == _selectedDriver));
        }
      },
    );
  }

  void _selectDriver(BuildContext context, Driver driver) {
    setState(() {
      if (_selectedDriver == null) {
        _selectedDriver = driver;
      } else if (_selectedDriver == driver) {
        _selectedDriver = null;
      } else {
        _openComparisionScreen(context, _selectedDriver, driver);
        _selectedDriver = null;
      }
    });
  }

  void _openComparisionScreen(BuildContext context, Driver selectedDriver, Driver driver) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CompareDriversScreen(year: widget.year, driver1Id: selectedDriver.id, driver2Id: driver.id)));
  }

  Widget _createHeaderItem() {
    return Column(
      children: [
        Image(
          width: 300.0,
          image: AssetImage('assets/F1-Logo.png'),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 32.0),
          child: Text(
            '${widget.year} F1 World Championship',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 32.0),
          child: Text(
            'Select two drivers to compare their performance',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _error() {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text("Failed to load"));
  }
}
