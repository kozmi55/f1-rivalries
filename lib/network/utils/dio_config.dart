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
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) => options.method == 'GET' ? interceptor.onRequest(options, handler) : handler.next(options),
      onResponse: (Response response, ResponseInterceptorHandler handler) => response.requestOptions.method == 'GET' ? interceptor.onResponse(response, handler) : handler.next(response),
      onError: (DioError e, ErrorInterceptorHandler handler) => handler.next(e), // interceptor falls back to cache on error, a behavior we currently don't want
    );
  }
}