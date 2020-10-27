import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';
import 'package:flutter/widgets.dart';

class DriverRowWidget extends StatelessWidget {
  final Driver driver;

  const DriverRowWidget({Key key, this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(driver.name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
        Container(
            alignment: Alignment.centerLeft,
            child: Text(driver.nationality,
                style: TextStyle(
                    fontSize: 12.0, color: Color.fromARGB(255, 128, 128, 128))))
      ],
    );
  }
}
