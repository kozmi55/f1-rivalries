import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioConfig {
  final String baseUrl;

  DioConfig({this.baseUrl = 'http://ergast.com/api/f1'});

  Dio get dio {
    final cacheOptions = buildCacheOptions(Duration(days: 1));

    final options = BaseOptions(baseUrl: baseUrl, extra: cacheOptions.extra);

    final dio = Dio(options);

    dio.interceptors.add(_cacheInterceptor());

    return dio;
  }

  Interceptor _cacheInterceptor() {
    Interceptor interceptor = DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor;
    return InterceptorsWrapper(
      onRequest: (RequestOptions options) => options.method == 'GET' ? interceptor.onRequest(options) : options,
      onResponse: (Response response) => response.request.method == 'GET' ? interceptor.onResponse(response) : response,
      onError: (DioError e) => e, // interceptor falls back to cache on error, a behavior we currently don't want
    );
  }
}