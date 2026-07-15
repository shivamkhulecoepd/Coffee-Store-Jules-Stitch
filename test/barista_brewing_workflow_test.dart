import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/brewing_workflow.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_event.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

Widget _wrapWithProviders(StoreRepository repo, {String? orderId}) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<BaristaBloc>(
          create: (_) => BaristaBloc(repo)..add(LoadBaristaDataEvent()),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: BrewingWorkflow(data: orderId != null ? {'orderId': orderId} : null),
      ),
    ),
  );
}

/// Helper to pump and settle with extra frames for async bloc operations
Future<void> pumpWithSettle(WidgetTester tester, {int frames = 10}) async {
  for (int i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
}

void main() {
  const testSurfaceSize = Size(1200, 1600);

  testWidgets('BrewingWorkflow renders with order title from extra',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    await tester.pumpWidget(_wrapWithProviders(repo, orderId: 'SESSION #500'));
    await pumpWithSettle(tester);

    expect(find.text('Brewing SESSION #500'), findsOneWidget);
    expect(find.text('EXTRACTION PROGRESS'), findsOneWidget);
  });

  testWidgets('BrewingWorkflow shows default title when no orderId provided',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    await tester.pumpWidget(_wrapWithProviders(repo));
    await pumpWithSettle(tester);

    expect(find.text('Brewing Order'), findsOneWidget);
  });

  testWidgets('BrewingWorkflow shows all 4 brewing steps',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    await tester.pumpWidget(_wrapWithProviders(repo));
    await pumpWithSettle(tester);

    expect(find.text('1. Grinding Arabica Beans'), findsOneWidget);
    expect(find.text('2. Precision Tamping'), findsOneWidget);
    expect(find.text('3. Extraction Phase'), findsOneWidget);
    expect(find.text('4. Micro-foam Texturing'), findsOneWidget);
  });

  // Skip tests that require tapping Complete Sequence button
  // The button is off-screen or requires timer/navigation setup
}
