import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/main.dart';

void main() {
  testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const BeanAndBrewOS());
    expect(find.text('BEAN & BREW'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
