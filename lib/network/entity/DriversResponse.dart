class DriversResponse {
  final List<DriverEntity> drivers;

  DriversResponse(this.drivers);

  factory DriversResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> mrData = json['MRData'];
    final Map<String, dynamic> driverTable = mrData['DriverTable'];
    final List<Map<String, dynamic>> driversList = List<Map<String, dynamic>>.from(driverTable['Drivers']);

    final driverEntities = driversList.map((driverJson) => DriverEntity.fromJson(driverJson)).toList();
    return DriversResponse(driverEntities);
  }
}

class DriverEntity {
  final String driverId;
  final String givenName;
  final String familyName;
  final String dateOfBirth;
  final String code;
  final String nationality;

  DriverEntity(
      {this.driverId, this.givenName, this.familyName, this.dateOfBirth,
        this.code, this.nationality});

  factory DriverEntity.fromJson(Map<String, dynamic> json) {
    return DriverEntity(
        driverId: json['driverId'],
        givenName: json['givenName'],
        familyName: json['familyName'],
        dateOfBirth: json['dateOfBirth'],
        code: json['code'],
        nationality: json['nationality']);
  }
}