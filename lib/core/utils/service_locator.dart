import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/ordering/bloc/ordering_bloc.dart';
import '../../features/barista/bloc/barista_bloc.dart';
import '../../features/admin/bloc/admin_bloc.dart';
import '../../features/account/bloc/user_bloc.dart';
import '../../data/repositories/store_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Repositories
  sl.registerLazySingleton(() => StoreRepository());

  // Blocs
  sl.registerFactory(() => AuthBloc());
  sl.registerLazySingleton(() => OrderingBloc(sl()));
  sl.registerLazySingleton(() => BaristaBloc(sl()));
  sl.registerLazySingleton(() => AdminBloc(sl()));
  sl.registerLazySingleton(() => UserBloc());
}
