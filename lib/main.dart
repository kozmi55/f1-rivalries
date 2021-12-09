import 'dart:async';

import 'package:f1_stats_app/screens/choose_year/choose_year_screen.dart';
import 'package:f1_stats_app/utils/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runZoned(() async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChooseYearScreen(title: 'F1 stats'),
    );
  }
}
