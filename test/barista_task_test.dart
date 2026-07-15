import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/operational_tasks.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/task_detail_page.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_event.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

// Test router configuration
final _testRouter = GoRouter(
  initialLocation: '/tasks',
  routes: [
    GoRoute(
      path: '/tasks',
      name: 'tasks',
      builder: (context, state) => const OperationalTasksPage(),
    ),
    GoRoute(
      path: '/task-detail',
      name: 'task-detail',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return TaskDetailPage(data: extra ?? {});
      },
    ),
  ],
);

Widget _wrapWithRouter(StoreRepository repo) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<BaristaBloc>(
          create: (_) => BaristaBloc(repo)..add(LoadBaristaDataEvent()),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme.darkTheme,
        routerConfig: _testRouter,
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
  // Use larger surface size for buttons to be tappable
  const testSurfaceSize = Size(1200, 1600);

  group('OperationalTasksPage', () {
    testWidgets('shows tasks loaded from repository',
        (WidgetTester tester) async {
      tester.view.physicalSize = testSurfaceSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = StoreRepository();
      await tester.pumpWidget(_wrapWithRouter(repo));
      await pumpWithSettle(tester);

      // Default tasks from StoreRepository: Machine Calibration (PENDING),
      // Inventory Check (COMPLETED)
      expect(find.text('Machine Calibration'), findsOneWidget);
      expect(find.text('Inventory Check'), findsOneWidget);
    });

    testWidgets('tapping a task navigates to task detail',
        (WidgetTester tester) async {
      tester.view.physicalSize = testSurfaceSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = StoreRepository();
      await tester.pumpWidget(_wrapWithRouter(repo));
      await pumpWithSettle(tester);

      await tester.tap(find.text('Machine Calibration'));
      await tester.pumpAndSettle();

      expect(find.text('Protocol Detail'), findsOneWidget);
      expect(find.text('Machine Calibration'), findsWidgets);
    });
  });

  group('TaskDetailPage', () {
    testWidgets('displays task title from navigation extra',
        (WidgetTester tester) async {
      tester.view.physicalSize = testSurfaceSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = StoreRepository();
      await tester.pumpWidget(_wrapWithRouter(repo));
      await pumpWithSettle(tester);

      // Navigate to task detail
      await tester.tap(find.text('Machine Calibration'));
      await tester.pumpAndSettle();

      expect(find.text('Machine Calibration'), findsWidgets);
      expect(find.text('COMPLETE PROTOCOL'), findsOneWidget);
    });

    testWidgets('complete button marks task as completed in bloc state',
        (WidgetTester tester) async {
      tester.view.physicalSize = testSurfaceSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = StoreRepository();
      await tester.pumpWidget(_wrapWithRouter(repo));
      await pumpWithSettle(tester);

      // Navigate to task detail
      await tester.tap(find.text('Machine Calibration'));
      await tester.pumpAndSettle();

      // Scroll the complete button into view and tap
      await tester.scrollUntilVisible(
        find.text('COMPLETE PROTOCOL'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('COMPLETE PROTOCOL'));
      await tester.pumpAndSettle();

      // After completing, the task should be marked COMPLETED in repository
      final task = repo.tasks.firstWhere((t) => t['title'] == 'Machine Calibration');
      expect(task['status'], 'COMPLETED');
      expect(task['color'], 'success');
    });

    testWidgets('complete button pops navigation after completing',
        (WidgetTester tester) async {
      tester.view.physicalSize = testSurfaceSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = StoreRepository();
      await tester.pumpWidget(_wrapWithRouter(repo));
      await pumpWithSettle(tester);

      // Navigate to task detail
      await tester.tap(find.text('Machine Calibration'));
      await tester.pumpAndSettle();

      // Scroll and tap complete button
      await tester.scrollUntilVisible(
        find.text('COMPLETE PROTOCOL'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('COMPLETE PROTOCOL'));
      await tester.pumpAndSettle();

      // After completion, should navigate back (Protocol Detail screen gone)
      expect(find.text('Protocol Detail'), findsNothing);
    });
  });
}
