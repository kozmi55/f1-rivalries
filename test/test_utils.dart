import 'package:get_it/get_it.dart';

void setupTestLocator(config(GetIt locator)) {
  final locator = GetIt.instance;
  locator.reset();
  locator.allowReassignment = true; // Allows reassignment by the config block

  config(locator);
}