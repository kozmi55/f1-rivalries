import 'package:flutter/widgets.dart';

class CompareDriverRow extends StatelessWidget {
  final String description;
  final String driverData1;
  final String driverData2;

  CompareDriverRow({Key key, this.description, this.driverData1, this.driverData2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 3, child: Text(description)),
      Expanded(flex: 3, child: Text(driverData1)),
      Expanded(flex: 3, child: Text(driverData2))
    ]);
  }
}
