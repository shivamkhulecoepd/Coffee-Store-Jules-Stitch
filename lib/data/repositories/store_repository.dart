import 'dart:async';
import '../../features/ordering/models/product_model.dart';

class StoreRepository {
  // Enhanced Mock Data with real-world coffee images and detailed descriptions
  final List<Product> _products = [
    const Product(
      id: '1',
      name: 'Signature Vanilla Latte',
      description: 'Our house specialty. A velvety smooth double-shot of our premium espresso balanced with perfectly steamed organic whole milk and infused with Madagascar bourbon vanilla bean syrup. Finished with a delicate micro-foam heart.',
      price: 5.50,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'v_latte',
      imageUrl: 'https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '2',
      name: 'Caramel Macchiato',
      description: 'Freshly steamed milk with vanilla-flavored syrup marked with espresso and topped with a decadent caramel drizzle. A layered masterpiece of sweetness and caffeine.',
      price: 6.00,
      rating: 4.9,
      category: 'ESPRESSO',
      heroTag: 'macchiato',
      imageUrl: 'https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '3',
      name: 'Ethiopian Yirgacheffe',
      description: 'Single-origin heirloom beans from the Yirgacheffe region. These beans are medium-light roasted to preserve their characteristic bright acidity, floral jasmine aroma, and complex citrus notes.',
      price: 18.00,
      rating: 4.7,
      category: 'BEANS',
      heroTag: 'ethiopian',
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '4',
      name: 'Artisan Cold Brew',
      description: 'Steeped for 24 hours in small batches to extract the smoothest, least acidic coffee experience. Served over ice with a hint of dark chocolate notes.',
      price: 4.50,
      rating: 4.6,
      category: 'COLD',
      heroTag: 'cold_brew',
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4bb1db41?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '5',
      name: 'Cortado',
      description: 'The purist\'s choice. Equal parts espresso and warm silky milk to reduce the acidity. A perfect balance of strength and texture.',
      price: 4.25,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'cortado',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '6',
      name: 'Nitro Nitro Cold Brew',
      description: 'Infused with nitrogen as it pours from the tap, our Cold Brew is transformed into a rich, creamy beverage with a cascading crema and a naturally sweet finish.',
      price: 5.75,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'nitro',
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '7',
      name: 'Sumatra Dark Roast',
      description: 'Heavy-bodied and earthy with low acidity. These beans are dark roasted to bring out deep herbal and spicy notes with a long-lasting smoky finish.',
      price: 16.50,
      rating: 4.5,
      category: 'BEANS',
      heroTag: 'sumatra',
      imageUrl: 'https://images.unsplash.com/photo-1580915411954-282cb1b0d780?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '8',
      name: 'Matcha Green Tea Latte',
      description: 'Premium ceremonial grade Japanese matcha whisked with velvety steamed milk. A vibrant, antioxidant-rich alternative to coffee.',
      price: 5.25,
      rating: 4.7,
      category: 'TEA',
      heroTag: 'matcha',
      imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '9',
      name: 'Flat White',
      description: 'A double shot of espresso topped with a thin layer of micro-foam, providing a higher coffee-to-milk ratio for a stronger flavor.',
      price: 4.75,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'flat_white',
      imageUrl: 'https://images.unsplash.com/photo-1570968015848-fd2809228995?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '10',
      name: 'Cascara Tea',
      description: 'Brewed from the dried skins of coffee cherries, this tea has a unique flavor profile with notes of rosehip, hibiscus, and red currant.',
      price: 4.00,
      rating: 4.4,
      category: 'TEA',
      heroTag: 'cascara',
      imageUrl: 'https://images.unsplash.com/photo-1594631252845-29fc45865157?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '11',
      name: 'Iced Spanish Latte',
      description: 'Our Signature espresso combined with sweetened condensed milk and topped with fresh cold milk and ice. Perfectly sweet and refreshing.',
      price: 6.25,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'spanish_latte',
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '12',
      name: 'Colombian Supremo',
      description: 'Classic Colombian beans known for their balanced body, clean taste, and nutty undertones. A versatile bean for any brewing method.',
      price: 15.00,
      rating: 4.6,
      category: 'BEANS',
      heroTag: 'colombian',
      imageUrl: 'https://images.unsplash.com/photo-1611854779393-1b2da9d400fe?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '13',
      name: 'Almond Croissant',
      description: 'Butter croissant filled with sweet almond cream and topped with sliced almonds. Twice-baked for maximum crunch.',
      price: 4.50,
      rating: 4.9,
      category: 'PASTRY',
      heroTag: 'croissant',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '14',
      name: 'Blueberry Muffin',
      description: 'Bursting with fresh blueberries and topped with a crunchy streusel crumble. Moist and flavorful.',
      price: 3.75,
      rating: 4.7,
      category: 'PASTRY',
      heroTag: 'muffin',
      imageUrl: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?q=80&w=1000&auto=format&fit=crop',
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
