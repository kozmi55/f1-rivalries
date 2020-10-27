class ChooseDriversViewState {
  final List<Driver> _drivers;

  ChooseDriversViewState(this._drivers);

  List<Driver> get drivers => _drivers;
}

class Driver {
  final String _id;
  final String _name;
  final String _nationality;

  Driver(this._id, this._name, this._nationality);

  String get nationality => _nationality;

  String get name => _name;

  String get id => _id;
}