import 'dart:async';
import '../../features/ordering/models/product_model.dart';
import '../../features/barista/models/table_session_model.dart';
import '../../features/admin/models/inventory_item_model.dart';
import '../../features/admin/models/customer_request_model.dart';
import '../../features/admin/models/employee_model.dart';

/// Low-stock threshold — any item with progress below this is considered low.
const kLowStockThreshold = 0.25;

/// Critical-stock threshold — any item below this is considered critical.
const kCriticalStockThreshold = 0.15;

/// Central repository acting as single source of truth for Bean & Brew OS.
/// Uses in-memory state with Stream-based synchronization across modules.
class StoreRepository {
  // ─── Product Catalog ─────────────────────────────────────────────────────
  final List<Product> _products = [
    const Product(
      id: '1',
      name: 'Signature Vanilla Latte',
      description: 'Our house-specialty latte with Madagascar vanilla bean syrup and double-shot of our signature espresso blend.',
      price: 6.50,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'latte',
      imageUrl: 'https://images.unsplash.com/photo-1683122925249-8b15d807db4b?q=80&w=1930&auto=format&fit=crop',
    ),
    const Product(
      id: '2',
      name: 'Caramel Macchiato',
      description: 'Layers of rich espresso and freshly steamed milk meet a decadent caramel drizzle.',
      price: 6.00,
      rating: 4.9,
      category: 'ESPRESSO',
      heroTag: 'macchiato',
      imageUrl: 'https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '3',
      name: 'Cortado Premium',
      description: 'Spanish-inspired precision. Equal parts intense espresso and warm silky milk.',
      price: 4.25,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'cortado',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '4',
      name: 'Artisan Cold Brew',
      description: 'Time is the key ingredient. Steeped for 24 hours at precise temperatures.',
      price: 4.50,
      rating: 4.6,
      category: 'COLD',
      heroTag: 'cold_brew',
      imageUrl: 'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?q=80&w=686&auto=format&fit=crop',
    ),
    const Product(
      id: '5',
      name: 'Nitro Velvet Brew',
      description: 'Infused with nitrogen from the tap, this cold brew takes on a rich, creamy texture.',
      price: 5.75,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'nitro',
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '6',
      name: 'Ethiopian Yirgacheffe',
      description: 'Single-origin heirloom beans. Medium-light roast with bright acidity and complex citrus notes.',
      price: 18.00,
      rating: 4.7,
      category: 'BEANS',
      heroTag: 'ethiopian',
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '7',
      name: 'Ceremonial Matcha Latte',
      description: 'Grade A Japanese matcha whisked with velvety steamed milk.',
      price: 5.25,
      rating: 4.7,
      category: 'TEA',
      heroTag: 'matcha',
      imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '8',
      name: 'Almond Croissant',
      description: 'Pure French butter croissant filled with sweet almond frangipane cream.',
      price: 4.50,
      rating: 4.9,
      category: 'PASTRY',
      heroTag: 'croissant',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1000&auto=format&fit=crop',
    ),
  ];

  // ─── Tables ──────────────────────────────────────────────────────────────
  final List<TableSession> _tableSessions = List.generate(6, (i) => TableSession(tableId: i + 1));

  // ─── Inventory ────────────────────────────────────────────────────────────
  final List<InventoryItem> _inventory = [
    const InventoryItem(id: '104', name: 'Ethiopian Yirgacheffe', quantity: '14kg', progress: 0.4),
    const InventoryItem(id: '105', name: 'Whole Organic Milk', quantity: '5L', progress: 0.2),
    const InventoryItem(id: '106', name: 'Oat Milk (Barista Ed.)', quantity: '42L', progress: 0.8),
    const InventoryItem(id: '107', name: 'Vanilla Bean Syrup', quantity: '1.2L', progress: 0.15),
    const InventoryItem(id: '108', name: 'Caramel Syrup', quantity: '3.5L', progress: 0.6),
    const InventoryItem(id: '109', name: 'Matcha Powder', quantity: '0.8kg', progress: 0.1),
  ];

  // ─── Support & HR ────────────────────────────────────────────────────────
  final List<CustomerRequest> _requests = [
    const CustomerRequest(id: '8820', description: 'Inquiry regarding subscription renewal benefits.'),
    const CustomerRequest(id: '8821', description: 'Request for table #4 group booking reservation.'),
  ];

  final List<Employee> _employees = [
    const Employee(name: 'Sarah Miller', role: 'Head Barista', status: EmployeeStatus.onShift),
    const Employee(name: 'James Wilson', role: 'Junior Barista', status: EmployeeStatus.offShift),
    const Employee(name: 'Elena Rodriguez', role: 'Store Manager', status: EmployeeStatus.onShift),
  ];

  final List<Map<String, dynamic>> _suppliers = [
    {'name': 'Global Bean Co.', 'contact': 'supply@globalbean.com', 'category': 'BEANS'},
    {'name': 'Dairy Gold', 'contact': 'orders@dairygold.com', 'category': 'DAIRY'},
  ];

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Machine Calibration', 'status': 'PENDING', 'color': 'warning'},
    {'title': 'Inventory Check', 'status': 'COMPLETED', 'color': 'success'},
  ];

  // ─── Performance & Orders ─────────────────────────────────────────────────
  final Map<String, dynamic> _performance = {
    'ordersCompleted': 124,
    'avgTime': '4.2m',
    'rating': 4.9,
    'avgBrewTime': '28s',
    'score': 98.2,
  };

  final List<Map<String, dynamic>> _orders = [];

  // ─── Stream Controllers ───────────────────────────────────────────────────
  final StreamController<List<TableSession>> _tableController = StreamController.broadcast();
  final StreamController<List<Map<String, dynamic>>> _ordersController = StreamController.broadcast();
  final StreamController<List<InventoryItem>> _inventoryController = StreamController.broadcast();
  final StreamController<List<Employee>> _employeeController = StreamController.broadcast();
  final StreamController<List<CustomerRequest>> _requestsController = StreamController.broadcast();

  StoreRepository() {
    // Push initial state
    _tableController.add(List.unmodifiable(_tableSessions));
    _inventoryController.add(List.unmodifiable(_inventory));
    _employeeController.add(List.unmodifiable(_employees));
    _requestsController.add(List.unmodifiable(_requests));
  }

  // ─── Public Getters ──────────────────────────────────────────────────────

  List<Product> get products => _products;

  List<TableSession> get tableSessions => _tableSessions;
  List<TableSession> get tables => _tableSessions;
  Stream<List<TableSession>> get tableStream => _tableController.stream;

  List<InventoryItem> get inventory => _inventory;
  /// Stream of inventory items — emits when stock changes (e.g., after order or reorder).
  Stream<List<InventoryItem>> get inventoryStream => _inventoryController.stream;
  /// Returns items currently below low-stock threshold.
  List<InventoryItem> get lowStockItems =>
      _inventory.where((i) => i.progress < kLowStockThreshold).toList();
  /// Returns items in critical state.
  List<InventoryItem> get criticalStockItems =>
      _inventory.where((i) => i.progress < kCriticalStockThreshold).toList();

  List<CustomerRequest> get requests => _requests;
  Stream<List<CustomerRequest>> get requestsStream => _requestsController.stream;

  List<Employee> get employees => _employees;
  Stream<List<Employee>> get employeeStream => _employeeController.stream;

  List<Map<String, dynamic>> get suppliers => _suppliers;
  List<Map<String, dynamic>> get tasks => _tasks;
  Map<String, dynamic> get performance => _performance;

  List<Map<String, dynamic>> get orders => _orders;
  /// Stream of active orders — used by BaristaBloc to show the order queue.
  Stream<List<Map<String, dynamic>>> get ordersStream => _ordersController.stream;

  // ─── Product Actions ─────────────────────────────────────────────────────

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(isFavorite: !_products[index].isFavorite);
    }
  }

  // ─── Order Actions ───────────────────────────────────────────────────────

  /// Add a new order and broadcast to all listeners (Barista, Customer tracking).
  void addOrder(Map<String, dynamic> order) {
    _orders.insert(0, order);
    _ordersController.add(List.unmodifiable(_orders));
  }

  /// Update the status of an existing order (e.g., 'Preparing' → 'Ready').
  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o['id'] == orderId);
    if (index != -1) {
      _orders[index] = {..._orders[index], 'status': newStatus};
      _ordersController.add(List.unmodifiable(_orders));
    }
  }

  // ─── Inventory Actions ───────────────────────────────────────────────────

  /// Called when a customer places an order — reduces stock based on cart items.
  /// In a real app, this would be more sophisticated (ingredient mapping per product).
  void consumeInventoryForOrder(List<CartItem> cartItems) {
    // Decrement the general inventory progress by a small amount per item ordered
    final decrementAmount = 0.01 * cartItems.fold(0, (sum, item) => sum + item.quantity);
    for (var i = 0; i < _inventory.length; i++) {
      final current = _inventory[i].progress;
      final newProgress = (current - decrementAmount).clamp(0.0, 1.0);
      _inventory[i] = _inventory[i].copyWith(progress: newProgress);
    }
    _inventoryController.add(List.unmodifiable(_inventory));
  }

  /// Update the quantity and progress of an inventory item.
  void updateInventory(String id, String newQty, double newProgress) {
    final index = _inventory.indexWhere((i) => i.id == id);
    if (index != -1) {
      _inventory[index] = _inventory[index].copyWith(quantity: newQty, progress: newProgress);
      _inventoryController.add(List.unmodifiable(_inventory));
    }
  }

  /// Reorder an item — restores its stock to a healthy level.
  /// Returns the updated item, or null if not found.
  InventoryItem? reorderItem(String id, {double targetProgress = 0.9}) {
    final index = _inventory.indexWhere((i) => i.id == id);
    if (index == -1) return null;

    // Parse current quantity string and double it for reorder
    final currentQty = _inventory[index].quantity;
    final numericPart = double.tryParse(currentQty.replaceAll(RegExp(r'[^\d.]'), '')) ?? 1.0;
    final newQty = '${(numericPart * 2).toStringAsFixed(1)}${currentQty.replaceAll(RegExp(r'[\d.]'), '')}';

    _inventory[index] = _inventory[index].copyWith(
      quantity: newQty,
      progress: targetProgress,
    );
    _inventoryController.add(List.unmodifiable(_inventory));
    return _inventory[index];
  }

  // ─── Table Session Actions ───────────────────────────────────────────────

  void updateTableSession(TableSession session) {
    final index = _tableSessions.indexWhere((s) => s.tableId == session.tableId);
    if (index != -1) {
      _tableSessions[index] = session;
      _tableController.add(List.unmodifiable(_tableSessions));
    }
  }

  // ─── Employee Actions ────────────────────────────────────────────────────

  void updateEmployeeStatus(String name, EmployeeStatus status) {
    final index = _employees.indexWhere((e) => e.name == name);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(status: status);
      _employeeController.add(List.unmodifiable(_employees));
    }
  }

  // ─── Support Actions ─────────────────────────────────────────────────────

  void resolveRequest(String id) {
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(status: RequestStatus.resolved);
      _requestsController.add(List.unmodifiable(_requests));
    }
  }

  // ─── Cleanup ─────────────────────────────────────────────────────────────

  void dispose() {
    _tableController.close();
    _ordersController.close();
    _inventoryController.close();
    _employeeController.close();
    _requestsController.close();
  }
}
