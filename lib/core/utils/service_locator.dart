import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/ordering/bloc/ordering_bloc.dart';
import '../../features/barista/bloc/barista_bloc.dart';
import '../../features/admin/bloc/admin_bloc.dart';
import '../../features/admin/bloc/inventory_bloc.dart';
import '../../features/account/bloc/user_bloc.dart';
import '../../data/repositories/store_repository.dart';
import '../../services/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Services
  sl.registerLazySingleton(() => ApiService(sl()));

  // Repositories
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => StoreRepository());

  // Blocs
  sl.registerFactory(() => AuthBloc(sl<AuthRepository>()));
  sl.registerLazySingleton(() => OrderingBloc(sl<StoreRepository>()));
  sl.registerLazySingleton(() => BaristaBloc(sl<StoreRepository>()));
  sl.registerLazySingleton(() => AdminBloc(sl<StoreRepository>()));
  sl.registerLazySingleton(() => InventoryBloc(sl<StoreRepository>()));
  sl.registerLazySingleton(() => UserBloc());
}
