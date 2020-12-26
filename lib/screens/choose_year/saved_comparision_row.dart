import 'package:f1_stats_app/screens/choose_year/comparisions_list_view_state.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SavedComparisionRow extends StatelessWidget {
  final DriverComparision driverComparision;
  final Function onPop;

  SavedComparisionRow({Key key, this.driverComparision, this.onPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _openComparisionScreen(context),
        child: Stack(
          children: [
            Row(children: [
              Expanded(
                  flex: 5,
                  child: Container(
                      height: 64.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: Text(driverComparision.driverName1,
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0)))),
              Expanded(
                  flex: 2,
                  child: Container(
                      height: 64.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'vs',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      ))),
              Expanded(
                  flex: 5,
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(driverComparision.driverName2,
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0))))
            ]),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 4.0, right: 4.0),
                child: Text(driverComparision.year.toString(),
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  void _openComparisionScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompareDriversScreen(
                year: driverComparision.year,
                driver1Id: driverComparision.driverId1,
                driver2Id: driverComparision.driverId2))).then(onPop);
  }
}
