import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:f1_stats_app/db/comparisions_table.dart';
import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/network/entity/drivers_results_response.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';

void main() {
  final _driversApi = _MockDriversApi();
  final _comparisionTable = _MockComparisionTable();

  setupTestLocator((locator) {
    locator.registerFactory<DriversApi>(() => _driversApi);
    locator.registerFactory<ComparisionsTable>(() => _comparisionTable);
  });

  setUp(() {
    reset(_driversApi);
  });

  test('get driver results returns an error if first driver result results in an error', () async {
    // Given
    final driver2ResultsResponse = _createDriverResponse("hamilton");

    when(_driversApi.getDriverResultsForYear(2012, "vettel")).thenAnswer((realInvocation) => Future.error(Error()));
    when(_driversApi.getDriverResultsForYear(2012, "hamilton"))
        .thenAnswer((realInvocation) => Future.value(driver2ResultsResponse));

    try {
      // When
      await CompareDriversInteractor().getDriverResults(2012, "vettel", "hamilton");
    } catch (error) {
      // Than
      expect(error, isInstanceOf<Error>());
    }
  });

  test('get driver results returns an error if second driver result results in an error', () async {
    // Given
    final driver1ResultsResponse = _createDriverResponse("vettel");

    when(_driversApi.getDriverResultsForYear(2012, "vettel"))
        .thenAnswer((realInvocation) => Future.value(driver1ResultsResponse));
    when(_driversApi.getDriverResultsForYear(2012, "hamilton")).thenAnswer((realInvocation) => Future.error(Error()));

    try {
      // When
      await CompareDriversInteractor().getDriverResults(2012, "vettel", "hamilton");
    } catch (error) {
      // Than
      expect(error, isInstanceOf<Error>());
    }
  });

  test('get driver results returns a valid response when all the api calls are successful', () async {
    // Given
    final driver1ResultsResponse = _createDriverResponse("vettel");
    final driver2ResultsResponse = _createDriverResponse("hamilton");
    final driversForYearData = _dreateDriverForYearData(2012);

    when(_driversApi.getDriverResultsForYear(2012, "vettel"))
        .thenAnswer((realInvocation) => Future.value(driver1ResultsResponse));
    when(_driversApi.getDriverResultsForYear(2012, "hamilton"))
        .thenAnswer((realInvocation) => Future.value(driver2ResultsResponse));
    when(_driversApi.getDriversForYear(2012))
        .thenAnswer((realInvocation) => Future.value(Response(data: driversForYearData)));

    // When
    final results = await CompareDriversInteractor().getDriverResults(2012, "vettel", "hamilton");

    // Than
    expect(results, isInstanceOf<CompareDriversViewState>());
  });
}

Map<String, dynamic> _dreateDriverForYearData(int i) {
  return {
    'MRData': {
      'StandingsTable': {
        'StandingsLists': [
          {
            'DriverStandings': [
              {
                'position': '1',
                'points': '100',
                'Driver': {
                  'driverId': 'vettel',
                  'givenName': 'Sebastian',
                  'familyName': 'Vettel',
                  'dateOfBirth': '0',
                  'nationality': 'German'
                },
                'Constructors': []
              },
              {
                'position': '2',
                'points': '90',
                'Driver': {
                  'driverId': 'hamilton',
                  'givenName': 'Lewis',
                  'familyName': 'Hamilton',
                  'dateOfBirth': '0',
                  'nationality': 'British'
                },
                'Constructors': []
              }
            ]
          }
        ]
      }
    }
  };
}

DriverResultsResponse _createDriverResponse(String id) {
  final raceTableBuilder = RaceTableBuilder()
    ..races = ListBuilder()
    ..season = ""
    ..driverId = id;
  final mrDataBuilder = MrDataBuilder()..raceTable = raceTableBuilder;

  return DriverResultsResponse((b) => b..mrData = mrDataBuilder);
}

class _MockDriversApi extends Mock implements DriversApi {}

class _MockComparisionTable extends Mock implements ComparisionsTable {}
