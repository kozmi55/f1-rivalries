import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompareDriverRow extends StatelessWidget {
  final String description;
  final String driverData1;
  final String driverData2;
  final TextStyle driverDataStyle;
  final Color driver1Color;
  final Color driver2Color;

  CompareDriverRow(
      {Key key,
      this.description,
      this.driverData1,
      this.driverData2,
      this.driverDataStyle,
      this.driver1Color,
      this.driver2Color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
              ))),
      Expanded(
          flex: 3,
          child: Container(
              color: driver1Color ?? Colors.transparent,
              padding: EdgeInsets.all(8.0),
              child: Text(driverData1, textAlign: TextAlign.center, style: driverDataStyle ?? _getDefaultStyle()))),
      Expanded(
          flex: 3,
          child: Container(
              color: driver2Color ?? Colors.transparent,
              padding: EdgeInsets.all(8.0),
              child: Text(driverData2, textAlign: TextAlign.center, style: driverDataStyle ?? _getDefaultStyle())))
    ]);
  }

  TextStyle _getDefaultStyle() {
    return TextStyle(color: Colors.black, fontSize: 14.0);
  }
}
