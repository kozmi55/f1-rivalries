import 'package:dio/dio.dart';
import 'package:f1_stats_app/network/utils/dio_config.dart';

class DriversApi {
  Future<Response> getDriversForYear(int year) {
    return DioConfig().dio.get('/$year/drivers.json?limit=100');
  }
}
