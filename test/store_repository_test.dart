import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';
import 'package:coffee_store_jules_stitch/features/barista/models/table_session_model.dart';
import 'package:coffee_store_jules_stitch/features/ordering/models/product_model.dart';

void main() {
  late StoreRepository repo;

  setUp(() {
    repo = StoreRepository();
  });

  tearDown(() {
    repo.dispose();
  });

  group('Orders stream', () {
    test('addOrder inserts at beginning and emits via stream', () async {
      final emitted = <List<Map<String, dynamic>>>[];
      final sub = repo.ordersStream.listen(emitted.add);

      repo.addOrder({'id': 'TEST #1', 'status': 'Preparing', 'items': [], 'total': 10.0});
      await Future.delayed(const Duration(milliseconds: 50));

      expect(emitted.length, 1);
      expect(emitted.first.first['id'], 'TEST #1');
      expect(repo.orders.first['id'], 'TEST #1');

      await sub.cancel();
    });

    test('updateOrderStatus changes status and re-emits stream', () async {
      repo.addOrder({'id': 'TEST #2', 'status': 'Preparing', 'items': [], 'total': 5.0});
      await Future.delayed(const Duration(milliseconds: 30));

      final emitted = <List<Map<String, dynamic>>>[];
      final sub = repo.ordersStream.listen(emitted.add);

      repo.updateOrderStatus('TEST #2', 'Ready');
      await Future.delayed(const Duration(milliseconds: 50));

      expect(repo.getOrderById('TEST #2')?['status'], 'Ready');
      expect(emitted.isNotEmpty, true);

      await sub.cancel();
    });

    test('activeOrders returns only Preparing and Ready orders', () async {
      repo.addOrder({'id': 'TEST #3a', 'status': 'Preparing', 'items': [], 'total': 1.0});
      repo.addOrder({'id': 'TEST #3b', 'status': 'Ready', 'items': [], 'total': 2.0});
      repo.addOrder({'id': 'TEST #3c', 'status': 'Completed', 'items': [], 'total': 3.0});
      await Future.delayed(const Duration(milliseconds: 30));

      final active = repo.activeOrders;
      expect(active.length, 2);
      expect(active.any((o) => o['id'] == 'TEST #3a'), true);
      expect(active.any((o) => o['id'] == 'TEST #3b'), true);
      expect(active.any((o) => o['id'] == 'TEST #3c'), false);
    });
  });

  group('Table session management', () {
    test('setTableStatus updates a table and emits via stream', () async {
      final emitted = <List<TableSession>>[];
      final sub = repo.tableStream.listen(emitted.add);

      repo.setTableStatus(1, TableStatus.occupied);
      await Future.delayed(const Duration(milliseconds: 50));

      expect(repo.findTableById(1)?.status, TableStatus.occupied);
      expect(emitted.isNotEmpty, true);

      await sub.cancel();
    });

    test('addItemToTableSession adds item to table and sets status to occupied if vacant',
        () async {
      repo.addItemToTableSession(3, CartItem(
        product: const Product(
          id: '99',
          name: 'Espresso',
          description: 'Test',
          price: 3.00,
          rating: 4.0,
          category: 'ESPRESSO',
          heroTag: 'espresso',
          imageUrl: 'https://example.com/espresso.jpg',
        ),
        quantity: 1,
      ));

      final session = repo.findTableById(3);
      expect(session?.items.length, 1);
      expect(session?.items.first.product.name, 'Espresso');
      expect(session?.status, TableStatus.occupied);
    });

    test('findTableById returns session or null', () {
      expect(repo.findTableById(1)?.tableId, 1);
      expect(repo.findTableById(999), null);
    });
  });

  group('Performance', () {
    test('incrementOrdersCompleted increments counter and emits via stream',
        () async {
      final emitted = <Map<String, dynamic>>[];
      final sub = repo.performanceStream.listen(emitted.add);

      final initial = repo.performance['ordersCompleted'] as int;
      repo.incrementOrdersCompleted();
      await Future.delayed(const Duration(milliseconds: 50));

      expect(repo.performance['ordersCompleted'], initial + 1);
      expect(emitted.isNotEmpty, true);

      await sub.cancel();
    });
  });
}
