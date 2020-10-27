class DriversResponse {
  final List<DriverStanding> driverStandings;

  DriversResponse(this.driverStandings);

  factory DriversResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> mrData = json['MRData'];
    final Map<String, dynamic> standingsTable = mrData['StandingsTable'];
    final List<Map<String, dynamic>> standingsLists = List<Map<String, dynamic>>.from(standingsTable['StandingsLists']);
    final driverStandingsList = List<Map<String, dynamic>>.from(standingsLists[0]['DriverStandings']);

    final driverStandings = driverStandingsList.map((driverStandingJson) => DriverStanding.fromJson(driverStandingJson)).toList();
    return DriversResponse(driverStandings);
  }
}

class DriverStanding {
  final String position;
  final String points;
  final DriverEntity driverEntity;
  final List<Constructor> constructors;

  DriverStanding({this.position, this.points, this.driverEntity, this.constructors});

  factory DriverStanding.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> constructorList = List<Map<String, dynamic>>.from(json['Constructors']);

    return DriverStanding(
        position: json['position'],
        points: json['points'],
        driverEntity: DriverEntity.fromJson(json['Driver']),
        constructors: constructorList.map((constructorJson) => Constructor.fromJson(constructorJson)).toList());
  }
}

class DriverEntity {
  final String driverId;
  final String givenName;
  final String familyName;
  final String dateOfBirth;
  final String nationality;

  DriverEntity({this.driverId, this.givenName, this.familyName, this.dateOfBirth, this.nationality});

  factory DriverEntity.fromJson(Map<String, dynamic> json) {
    return DriverEntity(
        driverId: json['driverId'],
        givenName: json['givenName'],
        familyName: json['familyName'],
        dateOfBirth: json['dateOfBirth'],
        nationality: json['nationality']);
  }
}

class Constructor {
  final String constructorId;
  final String name;

  Constructor({this.constructorId, this.name});

  factory Constructor.fromJson(Map<String, dynamic> json) {
    return Constructor(constructorId: json['constructorId'], name: json['name']);
  }
}