import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_screen.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_view_state.dart';
import 'package:f1_stats_app/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';

void main() {
  final _interactor = _MockCompareDriversInteractor();

  setupTestLocator((locator) {
    locator.registerFactory<CompareDriversInteractor>(() => _interactor);
  });

  setUp(() {
    reset(_interactor);
  });

  testWidgets('Show loading while waiting for data', (tester) async {
    when(_interactor.getDriverResults(any, any, any)).thenAnswer((realInvocation) => Future.value());

    await tester
        .pumpWidget(createWidgetForTesting(CompareDriversScreen(year: 2010, driver1Id: 'vettel', driver2Id: 'alonso')));

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets('Dont show loading when data loading finished', (tester) async {
    when(_interactor.getDriverResults(any, any, any)).thenAnswer((realInvocation) => Future.value());

    await tester
        .pumpWidget(createWidgetForTesting(CompareDriversScreen(year: 2010, driver1Id: 'vettel', driver2Id: 'alonso')));
    await tester.pumpAndSettle();

    expect(find.byType(LoadingIndicator), findsNothing);
  });

  testWidgets('Show error when data loading results in an error.', (tester) async {
    when(_interactor.getDriverResults(any, any, any)).thenAnswer((realInvocation) => Future.error(Error()));

    await tester
        .pumpWidget(createWidgetForTesting(CompareDriversScreen(year: 2010, driver1Id: 'vettel', driver2Id: 'alonso')));
    await tester.pumpAndSettle();

    expect(find.text('Failed to load'), findsOneWidget);
  });

  testWidgets('Show correct data, when data is loaded', (tester) async {
    final driverResults1 = DriverResults('Sebastian Vettel', 1, 200, 15, 5, 10, 15, 10);
    final driverResults2 = DriverResults('Fernando Alonso', 2, 180, 14, 4, 10, 13, 7);
    final compareDriversViewState = CompareDriversViewState(driverResults1, driverResults2);

    when(_interactor.getDriverResults(any, any, any))
        .thenAnswer((realInvocation) => Future.value(compareDriversViewState));

    await tester
        .pumpWidget(createWidgetForTesting(CompareDriversScreen(year: 2010, driver1Id: 'vettel', driver2Id: 'alonso')));
    await tester.pumpAndSettle();

    expect(find.text('Sebastian Vettel'), findsOneWidget);
    expect(find.text('Fernando Alonso'), findsOneWidget);
    expect(find.text('1.'), findsOneWidget);
    expect(find.text('200 pts.'), findsOneWidget);
    expect(find.text('15 pts.'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('10'), findsNWidgets(3));
    expect(find.text('15'), findsOneWidget);
    expect(find.text('2.'), findsOneWidget);
    expect(find.text('180 pts.'), findsOneWidget);
    expect(find.text('14 pts.'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('13'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
  });
}

Widget createWidgetForTesting(Widget child) {
  return MaterialApp(
    home: child,
  );
}

class _MockCompareDriversInteractor extends Mock implements CompareDriversInteractor {}
