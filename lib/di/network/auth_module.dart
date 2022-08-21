import 'package:get_it/get_it.dart';

import '../../presenter/bloc/auth/auth_bloc.dart';

Future<void> init(GetIt getIt)async {

  getIt.registerLazySingleton(() => AuthBloc());

}