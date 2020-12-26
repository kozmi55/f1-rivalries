class ComparisionsListViewState {
  final List<ComparisionListItem> recentComparisions;

  ComparisionsListViewState(this.recentComparisions);
}

abstract class ComparisionListItem {}

class HeaderItem implements ComparisionListItem {
  final String title;

  HeaderItem(this.title);
}

class DriverComparision implements ComparisionListItem {
  final int year;
  final String driverId1;
  final String driverId2;
  final String driverName1;
  final String driverName2;

  DriverComparision(this.year, this.driverId1, this.driverId2, this.driverName1, this.driverName2);
}
