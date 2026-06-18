import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/main.dart';

void main() {
  testWidgets('App starts with WelcomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const BeanAndBrewOS());
    expect(find.text('Experience the Art of Coffee'), findsOneWidget);
  });
}
