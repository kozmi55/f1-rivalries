import 'package:get_it/get_it.dart';

void setupTestLocator(config(GetIt locator)) async {
  final locator = GetIt.instance;
  await locator.reset();
  locator.allowReassignment = true; // Allows reassignment by the config block

  config(locator);
}