import 'package:get_it/get_it.dart';
import 'package:square_tickets/data/remote/repository/data_repository.dart';
import 'package:square_tickets/data/remote/square_checkout/repository/square_checkout_rpository.dart';
Future init(GetIt getIt) async {
  getIt.registerLazySingleton(() => SquareCheckoutRepository(getIt.get()));
  getIt.registerLazySingleton(() => DataRepository());
}
