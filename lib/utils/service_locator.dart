
import 'package:f1_stats_app/network/api/drivers_api.dart';
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_interactor.dart';
import 'package:f1_stats_app/screens/compare_drivers/compare_drivers_interactor.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<DriversApi>(() => DriversApi());

  locator.registerFactory<ChooseDriversInteractor>(() => ChooseDriversInteractor());
  locator.registerFactory<CompareDriversInteractor>(() => CompareDriversInteractor());
}