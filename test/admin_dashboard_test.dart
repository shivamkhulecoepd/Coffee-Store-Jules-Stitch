import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/admin/screens/manager_dashboard.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

void main() {
  testWidgets('ManagerDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: const ManagerDashboard(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Executive Control'), findsOneWidget);
    expect(find.text('DAILY REVENUE'), findsOneWidget);
  });
}
