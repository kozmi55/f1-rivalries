import 'package:hive/hive.dart';

part 'driver_comparision_data.g.dart';

@HiveType(typeId: 1)
class DriverComparisionData {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int year;

  @HiveField(2)
  final String driverId1;

  @HiveField(3)
  final String driverId2;

  @HiveField(4)
  final String driverName1;

  @HiveField(5)
  final String driverName2;

  @HiveField(6)
  final int timestamp;

  DriverComparisionData(this.id, this.year, this.driverId1, this.driverId2, this.driverName1, this.driverName2, this.timestamp);
}