
import 'package:f1_stats_app/screens/choose_driver/choose_drivers_interactor.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<ChooseDriversInteractor>(() => ChooseDriversInteractor());
}