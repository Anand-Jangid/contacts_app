import 'package:contacts_app/Database/contact_database.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ContactDatabase>(() => ContactDatabase());
}
