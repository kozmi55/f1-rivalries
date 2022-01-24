
import 'package:f1_stats_app/db/comparisions_cache.dart';
import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_interactor.dart';
import 'package:f1_stats_app/screens/choose_year/comparisions_list_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<ComparisionsCache>(() => ComparisionsCache());
  locator.registerLazySingleton<HiveInterface>(() => Hive);
  locator.registerLazySingleton<DriversApi>(() => DriversApi());

  locator.registerFactory<ChooseDriversInteractor>(() => ChooseDriversInteractor());
  locator.registerFactory<CompareDriversInteractor>(() => CompareDriversInteractor());
  locator.registerFactory<ComparisionsListInteractor>(() => ComparisionsListInteractor());
}