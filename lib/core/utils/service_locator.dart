import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Services
  // TODO: Register actual services here

  // Repositories
  // TODO: Register actual repositories here

  // Blocs
  // TODO: Register actual blocs here
}
