class ChooseDriversViewState {
  final List<Driver> _drivers;

  ChooseDriversViewState(this._drivers);

  List<Driver> get drivers => _drivers;
}

class Driver {
  final String _id;
  final String _name;
  final String _constructorName;

  Driver(this._id, this._name, this._constructorName);

  String get constructorName => _constructorName;

  String get name => _name;

  String get id => _id;
}