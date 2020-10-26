import 'package:f1_stats_app/screens/choose_driver/choose_drivers_view_state.dart';
import 'package:flutter/widgets.dart';

class DriverRowWidget extends StatelessWidget {
  final Driver driver;

  const DriverRowWidget({Key key, this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text(driver.name)),
        Container(
            alignment: Alignment.centerLeft,
            child: Text(driver.constructorName))
      ],
    );
  }
}
