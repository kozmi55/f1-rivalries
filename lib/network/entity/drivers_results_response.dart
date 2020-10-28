import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'drivers_results_response.g.dart';

abstract class DriverResultsResponse implements Built<DriverResultsResponse, DriverResultsResponseBuilder> {

  DriverResultsResponse._();

  factory DriverResultsResponse([void Function(DriverResultsResponseBuilder) updates]) = _$DriverResultsResponse;

  static Serializer<DriverResultsResponse> get serializer => _$driverResultsResponseSerializer;

  @BuiltValueField(wireName: 'MRData')
  MrData get mrData;
}

abstract class MrData implements Built<MrData, MrDataBuilder> {

  MrData._();

  factory MrData([void Function(MrDataBuilder) updates]) = _$MrData;

  static Serializer<MrData> get serializer => _$mrDataSerializer;

  @BuiltValueField(wireName: 'RaceTable')
  RaceTable get raceTable;
}

abstract class RaceTable implements Built<RaceTable, RaceTableBuilder> {

  RaceTable._();

  factory RaceTable([void Function(RaceTableBuilder) updates]) = _$RaceTable;

  static Serializer<RaceTable> get serializer => _$raceTableSerializer;

  String get season;

  String get driverId;

  @BuiltValueField(wireName: 'Races')
  BuiltList<Race> get races;
}

abstract class Race implements Built<Race, RaceBuilder> {

  Race._();

  factory Race([void Function(RaceBuilder) updates]) = _$Race;

  static Serializer<Race> get serializer => _$raceSerializer;

  String get round;

  String get raceName;

  @BuiltValueField(wireName: 'Results')
  BuiltList<Result> get results;
}

abstract class Result implements Built<Result, ResultBuilder> {

  Result._();

  factory Result([void Function(ResultBuilder) updates]) = _$Result;

  static Serializer<Result> get serializer => _$resultSerializer;

  String get position;

  String get positionText;

  String get points;

  String get status;

  @BuiltValueField(wireName: 'Driver')
  Driver get driver;
}

abstract class Driver implements Built<Driver, DriverBuilder> {

  Driver._();

  factory Driver([void Function(DriverBuilder) updates]) = _$Driver;

  static Serializer<Driver> get serializer => _$driverSerializer;

  String get givenName;

  String get familyName;
}