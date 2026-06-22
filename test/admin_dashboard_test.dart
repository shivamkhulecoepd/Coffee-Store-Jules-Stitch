import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/features/admin/screens/manager_dashboard.dart';
import 'package:coffee_store_jules_stitch/core/utils/service_locator.dart' as di;
import 'test_helpers.dart';

void main() {
  setUpAll(() async {
    await di.init();
  });

  testWidgets('ManagerDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterial(const ManagerDashboard()));
    await tester.pumpAndSettle();
    expect(find.text('Executive Control'), findsOneWidget);
  });
}
