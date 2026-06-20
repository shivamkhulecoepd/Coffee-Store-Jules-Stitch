import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/ordering/screens/product_details_page.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

void main() {
  testWidgets('ProductDetailsPage renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: const ProductDetailsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Vanilla Latte'), findsOneWidget);
  });
}
