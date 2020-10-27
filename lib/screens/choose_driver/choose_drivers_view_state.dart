class ChooseDriversViewState {
  final List<Driver> _drivers;

  ChooseDriversViewState(this._drivers);

  List<Driver> get drivers => _drivers;
}

class Driver {
  final String _id;
  final String _name;
  final String _constructors;
  final int _position;
  final String _points;

  Driver(this._id, this._name, this._constructors, this._position, this._points);

  String get constructors => _constructors;

  String get name => _name;

  String get id => _id;

  String get points => _points;

  int get position => _position;
}