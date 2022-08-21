import 'package:get_it/get_it.dart';
import 'package:square_tickets/di/network/auth_module.dart' as AuthModule;
import 'package:square_tickets/di/network/http_module.dart' as HttpModule;
import 'package:square_tickets/di/repository/repository_module.dart' as RepositoryModule;

final injector = GetIt.instance;

Future<void> setup()async {

  RepositoryModule.init(injector);
  HttpModule.init(injector);
  AuthModule.init(injector);
}