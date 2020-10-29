class RecentComparisionsViewState {
  final List<DriverComparision> recentComparisions;

  RecentComparisionsViewState(this.recentComparisions);
}

class DriverComparision {
  final int year;
  final String driverId1;
  final String driverId2;
  final String driverName1;
  final String driverName2;

  DriverComparision(this.year, this.driverId1, this.driverId2, this.driverName1, this.driverName2);
}
