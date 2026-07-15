import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:coffee_store_jules_stitch/core/utils/service_locator.dart' as di;
import 'package:coffee_store_jules_stitch/features/auth/bloc/auth_bloc.dart';
import 'package:coffee_store_jules_stitch/features/auth/repositories/auth_repository.dart';
import 'package:coffee_store_jules_stitch/features/admin/bloc/admin_bloc.dart';
import 'package:coffee_store_jules_stitch/features/ordering/bloc/ordering_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/account/bloc/user_bloc.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';

final getIt = GetIt.instance;

/// Initialize GetIt with mock-friendly singletons for testing.
/// Call this in setUp or setUpAll of widget tests that need GetIt.
/// Uses the provided storeRepository if given, otherwise creates a new one.
void setupGetItForTesting({StoreRepository? storeRepository, AuthRepository? authRepository}) {
  // Reset any existing registrations
  if (getIt.isRegistered<StoreRepository>()) {
    getIt.unregister<StoreRepository>();
  }
  if (getIt.isRegistered<AuthRepository>()) {
    getIt.unregister<AuthRepository>();
  }

  // Register mock-friendly instances
  getIt.registerSingleton<StoreRepository>(storeRepository ?? StoreRepository());
  getIt.registerSingleton<AuthRepository>(authRepository ?? AuthRepository());
}

/// Wraps a widget with Material, ScreenUtil, and all BLoC providers.
/// Use this in widget tests instead of raw `wrapWithMaterial`.
/// This version does NOT use GetIt - use wrapWithMaterialAndProvidersWithGetIt for widgets that need sl<>
Widget wrapWithMaterialAndProviders(Widget child) {
  HttpOverrides.global = _MockHttpOverrides();
  final storeRepository = StoreRepository();
  final authRepository = AuthRepository();

  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepository)),
        BlocProvider<OrderingBloc>(create: (_) => OrderingBloc(storeRepository)),
        BlocProvider<BaristaBloc>(create: (_) => BaristaBloc(storeRepository)),
        BlocProvider<AdminBloc>(create: (_) => AdminBloc(storeRepository)),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    ),
  );
}

/// Same as wrapWithMaterialAndProviders but uses GetIt registrations.
/// Use this for widgets that call sl<T>() directly (like BaristaDashboard).
Widget wrapWithMaterialAndProvidersWithGetIt(Widget child) {
  HttpOverrides.global = _MockHttpOverrides();

  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(getIt<AuthRepository>())),
        BlocProvider<OrderingBloc>(create: (_) => OrderingBloc(getIt<StoreRepository>())),
        BlocProvider<BaristaBloc>(create: (_) => BaristaBloc(getIt<StoreRepository>())),
        BlocProvider<AdminBloc>(create: (_) => AdminBloc(getIt<StoreRepository>())),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    ),
  );
}

/// Legacy alias for backward compatibility.
Widget wrapWithMaterial(Widget child) => wrapWithMaterialAndProviders(child);

/// Returns a mock [StoreRepository] pre-seeded with test data.
StoreRepository makeTestStoreRepository() => StoreRepository();

/// Returns a mock [AuthRepository] for auth testing.
AuthRepository makeTestAuthRepository() => AuthRepository();

// ─── Mock HTTP overrides ────────────────────────────────────────────────────

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _MockHttpClient();
}

class _MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  @override
  bool autoUncompress = true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  HttpHeaders get headers => _MockHttpHeaders();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => _transparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final Uint8List _transparentImage = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);
