import 'dart:async';
import '../../features/ordering/models/product_model.dart';

class StoreRepository {
  // Mock Data
  final List<Product> _products = [
    const Product(
      id: '1',
      name: 'Vanilla Latte',
      description: 'A velvety smooth double espresso balanced with steamed whole milk and house-made vanilla.',
      price: 5.50,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'v_latte',
    ),
    const Product(
      id: '2',
      name: 'Macchiato',
      description: 'Rich espresso marked with a dollop of thick, creamy milk foam.',
      price: 6.00,
      rating: 4.9,
      category: 'ESPRESSO',
      heroTag: 'macchiato',
    ),
    const Product(
      id: '3',
      name: 'Ethiopian Blend',
      description: 'Single origin beans featuring bright floral and citrus notes.',
      price: 8.00,
      rating: 4.7,
      category: 'BEANS',
      heroTag: 'ethiopian',
    ),
  ];

  final List<Map<String, dynamic>> _tables = List.generate(6, (i) => {
    'id': i + 1,
    'status': i % 3 == 0 ? 'Occupied' : 'Vacant',
    'total': i % 3 == 0 ? 24.50 : 0.0,
  });

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Daily Machine Backflush', 'status': 'URGENT', 'color': 'primary'},
    {'title': 'Grinder Calibration', 'status': 'PENDING', 'color': 'outline'},
    {'title': 'Inventory Log: Dairy', 'status': 'COMPLETED', 'color': 'success'},
    {'title': 'Restock Pastry Case', 'status': 'PENDING', 'color': 'outline'},
  ];

  final List<Map<String, dynamic>> _inventory = [
    {'id': '104', 'name': 'Ethiopian Yirgacheffe', 'qty': '14kg', 'progress': 0.4},
    {'id': '105', 'name': 'Whole Organic Milk', 'qty': '5L', 'progress': 0.2},
    {'id': '106', 'name': 'Oat Milk (Barista Ed.)', 'qty': '42L', 'progress': 0.8},
    {'id': '107', 'name': 'Vanilla Bean Syrup', 'qty': '1.2L', 'progress': 0.15},
  ];

  final List<Map<String, dynamic>> _suppliers = [
    {'name': 'Premium Bean Roasters Co.', 'status': 'Active', 'location': 'Highlands'},
    {'name': 'Organic Dairy Farm', 'status': 'Active', 'location': 'Valley'},
    {'name': 'Eco-Pack Solutions', 'status': 'Active', 'location': 'Port District'},
  ];

  final List<Map<String, dynamic>> _employees = [
    {'name': 'Sarah Miller', 'role': 'Head Barista', 'status': 'ON-SHIFT'},
    {'name': 'James Wilson', 'role': 'Junior Barista', 'status': 'OFF-SHIFT'},
    {'name': 'Elena Rodriguez', 'role': 'Store Manager', 'status': 'ON-SHIFT'},
  ];

  final Map<String, dynamic> _performance = {
    'score': 98.4,
    'trend': '+2.1%',
    'avgBrewTime': '2:14m',
    'accuracy': '100%',
    'rating': 4.9,
    'upsell': '12%',
  };

  final StreamController<List<Map<String, dynamic>>> _ordersController = StreamController.broadcast();
  final List<Map<String, dynamic>> _orders = [];

  List<Product> get products => _products;
  List<Map<String, dynamic>> get tables => _tables;
  List<Map<String, dynamic>> get tasks => _tasks;
  List<Map<String, dynamic>> get inventory => _inventory;
  List<Map<String, dynamic>> get suppliers => _suppliers;
  List<Map<String, dynamic>> get employees => _employees;
  Map<String, dynamic> get performance => _performance;
  Stream<List<Map<String, dynamic>>> get ordersStream => _ordersController.stream;

  void addOrder(Map<String, dynamic> order) {
    _orders.insert(0, order);
    _ordersController.add(List.from(_orders));
  }

  List<Map<String, dynamic>> get orders => _orders;
}
