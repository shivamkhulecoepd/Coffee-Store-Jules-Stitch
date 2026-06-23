import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/barista_dashboard.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

void main() {
  testWidgets('BaristaDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: const BaristaDashboard(),
        ),
      ),
    );

    // Wait for all animations and layouts to settle
    await tester.pumpAndSettle();

    // Verify critical elements are present
    expect(find.text('Barista Control'), findsOneWidget);
    expect(find.text('TOTAL ORDERS'), findsOneWidget);
  });
}
