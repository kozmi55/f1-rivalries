import 'package:dio/dio.dart';

class DioConfig {
  final String baseUrl;

  DioConfig({this.baseUrl = 'http://ergast.com/api/f1'});

  Dio get dio {
    final options = BaseOptions(baseUrl: baseUrl);

    final dio = Dio(options);

    return dio;
  }
}