import 'package:dio/dio.dart';
import 'package:f1_stats_app/network/entity/drivers_results_response.dart';
import 'package:f1_stats_app/network/utils/dio_config.dart';
import 'package:f1_stats_app/network/utils/serializers.dart';

class DriversApi {
  Future<Response> getDriversForYear(int year) {
    return DioConfig().dio.get('/$year/driverStandings.json?limit=100');
  }

  Future<DriverResultsResponse> getDriverResultsForYear(int year, String driverId) {
    final request = DioConfig().dio.get('/$year/drivers/$driverId/results.json?limit=100');
    return fetch(request);
  }
}
