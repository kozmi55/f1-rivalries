import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DriverRowWidget extends StatelessWidget {
  final Driver driver;
  final bool selected;

  const DriverRowWidget({Key key, this.driver, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.black12 : Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
              width: 32.0,
              margin: EdgeInsets.only(right: 8.0),
              child: Text('${driver.position}.', style: TextStyle(fontSize: 20.0))),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(driver.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(driver.constructors,
                        style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 128, 128, 128))))
              ],
            ),
          ),
          Spacer(),
          Container(child: Text('${driver.points} pts.', style: TextStyle(fontSize: 14.0)))
        ],
      ),
    );
  }
}
