import 'package:corona_tracker/stores/corona_store.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //Stores
  locator.registerLazySingleton(() => CoronaStore());

  //Utilities

  //Services

  //Controllers
}
