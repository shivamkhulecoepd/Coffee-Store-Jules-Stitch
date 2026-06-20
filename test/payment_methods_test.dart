import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/account/screens/payment_methods_page.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

void main() {
  testWidgets('PaymentMethodsPage renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: const PaymentMethodsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Wallet'), findsOneWidget);
  });
}
