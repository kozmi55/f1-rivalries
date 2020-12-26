
import 'package:f1_stats_app/db/comparisions_table.dart';
import 'package:f1_stats_app/db/db_wrapper.dart';
import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_interactor.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<DbWrapper>(() => DbWrapper());
  locator.registerLazySingleton<ComparisionsTable>(() => ComparisionsTable());

  locator.registerLazySingleton<DriversApi>(() => DriversApi());

  locator.registerFactory<ChooseDriversInteractor>(() => ChooseDriversInteractor());
  locator.registerFactory<CompareDriversInteractor>(() => CompareDriversInteractor());
  locator.registerFactory<ComparisionsListInteractor>(() => ComparisionsListInteractor());
}