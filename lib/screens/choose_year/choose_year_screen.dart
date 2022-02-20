import 'package:f1_stats_app/screens/choose_driver/choose_drivers_screen.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseYearScreen extends StatefulWidget {
  ChooseYearScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChooseYearScreenState createState() => _ChooseYearScreenState();
}

class _ChooseYearScreenState extends State<ChooseYearScreen> {
  int _year = 0;
  bool _shouldRefreshRecentSearches = false;

  void _setYear(int year) {
    setState(() {
      this._shouldRefreshRecentSearches = false;
      this._year = year;
    });
  }

  bool _isYearValid() {
    return _year >= 1950 && _year <= 2022;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody(context) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            margin: EdgeInsets.only(bottom: 16.0, top: 64.0),
            child: Text(
              'Select the year you want to compare performance of the drivers',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              width: 100.0,
              child: TextField(
                decoration: InputDecoration(hintText: 'Year'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) => _setYear(int.parse(value)),
              )),
          Container(
            width: 100,
            margin: EdgeInsets.only(bottom: 16.0),
            child: RaisedButton(
              child: Text('Search'),
              onPressed: _isYearValid() ? () => {_navigateToDriverSelection(context)} : null,
            ),
          ),
          Container(
            child: ComparisionsListView(shouldRefreshList: _shouldRefreshRecentSearches),
            margin: EdgeInsets.only(bottom: 16.0),
          )
        ],
      ),
    );
  }

  void _navigateToDriverSelection(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseDriversScreen(year: _year)))
        .then((value) => _invalidateRecentSearches());
  }

  _invalidateRecentSearches() {
    setState(() {
      _shouldRefreshRecentSearches = true;
    });
  }
}
