import 'dart:async';
import '../../features/ordering/models/product_model.dart';
import '../../features/barista/models/table_session_model.dart';
import '../../features/admin/models/inventory_item_model.dart';
import '../../features/admin/models/customer_request_model.dart';
import '../../features/admin/models/employee_model.dart';

class StoreRepository {
  final List<Product> _products = [
    const Product(
      id: '1',
      name: 'Signature Vanilla Latte',
      description: 'Our house-specialty latte with Madagascar vanilla bean syrup and double-shot of our signature espresso blend.',
      price: 6.50,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'latte',
      imageUrl: 'https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=1000&auto=format&fit=crop',
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
      id: '5',
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
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4bb1db41?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '6',
      name: 'Nitro Velvet Brew',
      description: 'Infused with nitrogen from the tap, this cold brew takes on a rich, creamy texture.',
      price: 5.75,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'nitro',
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '3',
      name: 'Ethiopian Yirgacheffe',
      description: 'Single-origin heirloom beans. Medium-light roast with bright acidity and complex citrus notes.',
      price: 18.00,
      rating: 4.7,
      category: 'BEANS',
      heroTag: 'ethiopian',
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '8',
      name: 'Ceremonial Matcha Latte',
      description: 'Grade A Japanese matcha whisked with velvety steamed milk.',
      price: 5.25,
      rating: 4.7,
      category: 'TEA',
      heroTag: 'matcha',
      imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '13',
      name: 'Almond Croissant',
      description: 'Pure French butter croissant filled with sweet almond frangipane cream.',
      price: 4.50,
      rating: 4.9,
      category: 'PASTRY',
      heroTag: 'croissant',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1000&auto=format&fit=crop',
    ),
  ];

  final List<TableSession> _tableSessions = List.generate(6, (i) => TableSession(tableId: i + 1));

  final List<InventoryItem> _inventory = [
    const InventoryItem(id: '104', name: 'Ethiopian Yirgacheffe', quantity: '14kg', progress: 0.4),
    const InventoryItem(id: '105', name: 'Whole Organic Milk', quantity: '5L', progress: 0.2),
    const InventoryItem(id: '106', name: 'Oat Milk (Barista Ed.)', quantity: '42L', progress: 0.8),
    const InventoryItem(id: '107', name: 'Vanilla Bean Syrup', quantity: '1.2L', progress: 0.15),
  ];

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

  final Map<String, dynamic> _performance = {
    'ordersCompleted': 124,
    'avgTime': '4.2m',
    'rating': 4.9,
    'avgBrewTime': '28s',
    'score': 98.2,
  };

  final List<Map<String, dynamic>> _orders = [];
  final StreamController<List<TableSession>> _tableController = StreamController.broadcast();
  final StreamController<List<Map<String, dynamic>>> _ordersController = StreamController.broadcast();

  StoreRepository() {
    // Initial data push
    _tableController.add(_tableSessions);
  }

  List<Product> get products => _products;
  List<TableSession> get tableSessions => _tableSessions;
  List<TableSession> get tables => _tableSessions; // Alias for BaristaBloc
  Stream<List<TableSession>> get tableStream => _tableController.stream;
  List<InventoryItem> get inventory => _inventory;
  List<CustomerRequest> get requests => _requests;
  List<Employee> get employees => _employees;
  List<Map<String, dynamic>> get suppliers => _suppliers;
  List<Map<String, dynamic>> get tasks => _tasks;
  Map<String, dynamic> get performance => _performance;
  List<Map<String, dynamic>> get orders => _orders;
  Stream<List<Map<String, dynamic>>> get ordersStream => _ordersController.stream;

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(isFavorite: !_products[index].isFavorite);
    }
  }

  void addOrder(Map<String, dynamic> order) {
    _orders.insert(0, order);
    _ordersController.add(List.from(_orders));
  }

  void updateTableSession(TableSession session) {
    final index = _tableSessions.indexWhere((s) => s.tableId == session.tableId);
    if (index != -1) {
      _tableSessions[index] = session;
      _tableController.add(List.from(_tableSessions));
    }
  }

  void updateInventory(String id, String newQty, double newProgress) {
    final index = _inventory.indexWhere((i) => i.id == id);
    if (index != -1) {
      _inventory[index] = _inventory[index].copyWith(quantity: newQty, progress: newProgress);
    }
  }

  void resolveRequest(String id) {
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(status: RequestStatus.resolved);
    }
  }

  void updateEmployeeStatus(String name, EmployeeStatus status) {
    final index = _employees.indexWhere((e) => e.name == name);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(status: status);
    }
  }
}
