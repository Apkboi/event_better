import 'package:get_it/get_it.dart';
import 'package:square_tickets/data/remote/square_checkout/repository/square_checkout_rpository.dart';
import 'package:square_tickets/helpers/http_helper.dart';
Future init(GetIt getIt) async {
  getIt.registerLazySingleton(() => HttpHelper());
}
