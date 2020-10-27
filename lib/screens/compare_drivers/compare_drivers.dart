import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompareDriversScreen extends StatefulWidget {
  final String driver1Id;
  final String driver2Id;

  CompareDriversScreen({Key key, this.driver1Id, this.driver2Id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompareDriversScreenState();
}

class _CompareDriversScreenState extends State<CompareDriversScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('${widget.driver1Id} vs ${widget.driver2Id}')));
  }
}
