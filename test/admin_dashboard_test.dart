import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/features/admin/screens/manager_dashboard.dart';
import 'test_helpers.dart';

void main() {
  testWidgets('ManagerDashboard renders without layout errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithMaterial(const ManagerDashboard()));
    await tester.pump();
    expect(find.text('Executive Control'), findsOneWidget);
  });
}
