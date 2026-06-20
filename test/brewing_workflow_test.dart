import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/brewing_workflow.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

void main() {
  testWidgets('BrewingWorkflow renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: const BrewingWorkflow(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('EXTRACTION PROGRESS'), findsOneWidget);
  });
}
