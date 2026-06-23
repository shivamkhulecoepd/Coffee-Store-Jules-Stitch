import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/features/ordering/screens/product_details_page.dart';
import 'package:coffee_store_jules_stitch/features/ordering/models/product_model.dart';
import 'package:coffee_store_jules_stitch/core/utils/service_locator.dart' as di;
import 'test_helpers.dart';

void main() {
  setUpAll(() async {
    await di.init();
  });

  testWidgets('ProductDetailsPage renders without layout errors', (WidgetTester tester) async {
    const product = Product(
      id: '1',
      name: 'Vanilla Latte',
      price: 6.5,
      description: 'Smooth and creamy',
      rating: 4.8,
      category: 'Coffee',
      heroTag: 'latte',
      imageUrl: 'https://example.com/latte.png'
    );

    await tester.pumpWidget(wrapWithMaterial(const ProductDetailsPage(data: {
      'product': product,
    })));
    await tester.pumpAndSettle();
    expect(find.text('Vanilla Latte'), findsOneWidget);
  });
}
