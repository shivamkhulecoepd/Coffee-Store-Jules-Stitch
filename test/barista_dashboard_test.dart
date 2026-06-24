import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/barista_dashboard.dart';
import 'test_helpers.dart';

void main() {
  testWidgets('BaristaDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterial(const BaristaDashboard()));
    await tester.pump();
    expect(find.text('Sarah Miller'), findsOneWidget);
  });
}
