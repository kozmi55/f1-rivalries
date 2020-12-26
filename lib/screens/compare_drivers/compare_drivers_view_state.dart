class CompareDriversViewState {
  final DriverResults driverResults1;
  final DriverResults driverResults2;
  final bool isFavorite;

  CompareDriversViewState(this.driverResults1, this.driverResults2, this.isFavorite);
}

class DriverResults {
  final String name;
  final int championshipPosition;
  final double championshipPoints;
  final double pointsPerRace;
  final int wins;
  final int podiums;
  final int pointsFinishes;
  final int headToHead;

  DriverResults(this.name, this.championshipPosition, this.championshipPoints, this.pointsPerRace, this.wins,
      this.podiums, this.pointsFinishes, this.headToHead);
}
