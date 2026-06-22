import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/barista_dashboard.dart';
import 'package:coffee_store_jules_stitch/core/utils/service_locator.dart' as di;
import 'test_helpers.dart';

void main() {
  setUpAll(() async {
    await di.init();
  });

  testWidgets('BaristaDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterial(const BaristaDashboard()));
    await tester.pumpAndSettle();
    expect(find.text('Barista Control'), findsOneWidget);
  });
}
