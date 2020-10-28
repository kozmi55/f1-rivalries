import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:f1_stats_app/network/entity/drivers_results_response.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

//add all of the built value types that require serialization
@SerializersFor([
  DriverResultsResponse,
  MrData,
  RaceTable,
  Race,
  Result
])

final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

/// Fetches and deserializes a response using the given [request].
Future<T> fetch<T>(Future<Response<dynamic>> request) async {
  try {
    final response = await request;
    return _deserialize<T>(response.data);
  } catch (e) {
    print(e);
    return Future.error(e);
  }
}

T _deserialize<T>(dynamic value) => serializers.deserializeWith<T>(serializers.serializerForType(T), value);