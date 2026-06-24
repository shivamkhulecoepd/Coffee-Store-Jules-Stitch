import 'dart:async';
import '../../features/ordering/models/product_model.dart';

class StoreRepository {
  // Extensive catalog of products for Bean & Brew OS
  final List<Product> _products = [
    // ESPRESSO
    const Product(
      id: '1',
      name: 'Signature Vanilla Latte',
      description: 'Our crown jewel. A velvety double-shot of our house-blend espresso, harmonized with organic whole milk and infused with hand-scraped Madagascar vanilla beans. A masterpiece of balance and aroma.',
      price: 5.50,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'v_latte',
      imageUrl: 'https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=1000&auto=format&fit=crop',
      brewSpecs: {'Body': 'Full', 'Temp': '92°C', 'Extraction': '28s'},
    ),
    const Product(
      id: '2',
      name: 'Caramel Macchiato',
      description: 'Layers of rich espresso and freshly steamed milk meet a decadent caramel drizzle. It starts with sweetness and ends with the bold kick of our dark roast.',
      price: 6.00,
      rating: 4.9,
      category: 'ESPRESSO',
      heroTag: 'macchiato',
      imageUrl: 'https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '5',
      name: 'Cortado Premium',
      description: 'Spanish-inspired precision. Equal parts intense espresso and warm silky milk, crafted to reduce acidity while maintaining the coffee\'s powerful profile.',
      price: 4.25,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'cortado',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '9',
      name: 'Flat White',
      description: 'The Australian classic. A thin layer of micro-foam atop a double ristretto shot, offering a higher coffee-to-milk ratio for those who appreciate the nuances of the roast.',
      price: 4.75,
      rating: 4.8,
      category: 'ESPRESSO',
      heroTag: 'flat_white',
      imageUrl: 'https://images.unsplash.com/photo-1570968015848-fd2809228995?q=80&w=1000&auto=format&fit=crop',
    ),

    // COLD
    const Product(
      id: '4',
      name: 'Artisan Cold Brew',
      description: 'Time is the key ingredient. Steeped for 24 hours at precise temperatures to extract deep chocolate and nutty notes without the bitterness. Served over crystal-clear ice.',
      price: 4.50,
      rating: 4.6,
      category: 'COLD',
      heroTag: 'cold_brew',
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4bb1db41?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '6',
      name: 'Nitro Velvet Brew',
      description: 'Experience the cascade. Infused with nitrogen from the tap, this cold brew takes on a Guinness-like texture with a rich, creamy head and a naturally sweet finish.',
      price: 5.75,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'nitro',
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '11',
      name: 'Iced Spanish Latte',
      description: 'A summer favorite. Our Signature espresso combined with sweetened condensed milk and topped with fresh cold milk and ice. The perfect refreshing indulgence.',
      price: 6.25,
      rating: 4.9,
      category: 'COLD',
      heroTag: 'spanish_latte',
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?q=80&w=1000&auto=format&fit=crop',
    ),

    // BEANS (WHOLE BEAN)
    const Product(
      id: '3',
      name: 'Ethiopian Yirgacheffe',
      description: 'Single-origin heirloom beans. Medium-light roast with bright acidity, floral jasmine aroma, and complex citrus notes. Ideal for pour-over brewing.',
      price: 18.00,
      rating: 4.7,
      category: 'BEANS',
      heroTag: 'ethiopian',
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '7',
      name: 'Sumatra Dark Roast',
      description: 'Deep, earthy, and bold. These beans are dark roasted to bring out heavy herbal and spicy notes with a long-lasting smoky finish. Low acidity, full body.',
      price: 16.50,
      rating: 4.5,
      category: 'BEANS',
      heroTag: 'sumatra',
      imageUrl: 'https://images.unsplash.com/photo-1580915411954-282cb1b0d780?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '12',
      name: 'Colombian Supremo',
      description: 'The quintessential coffee profile. Balanced body, clean taste, and distinct nutty undertones. A versatile bean that excels in any preparation method.',
      price: 15.00,
      rating: 4.6,
      category: 'BEANS',
      heroTag: 'colombian',
      imageUrl: 'https://images.unsplash.com/photo-1611854779393-1b2da9d400fe?q=80&w=1000&auto=format&fit=crop',
    ),

    // TEA
    const Product(
      id: '8',
      name: 'Ceremonial Matcha Latte',
      description: 'Grade A Japanese matcha whisked with velvety steamed milk. A vibrant, antioxidant-rich alternative for the health-conscious connoisseur.',
      price: 5.25,
      rating: 4.7,
      category: 'TEA',
      heroTag: 'matcha',
      imageUrl: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '10',
      name: 'Rose Cascara Tea',
      description: 'Brewed from the dried skins of organic coffee cherries. This "coffee-tea" hybrid features unique notes of rosehip, hibiscus, and red currant.',
      price: 4.00,
      rating: 4.4,
      category: 'TEA',
      heroTag: 'cascara',
      imageUrl: 'https://images.unsplash.com/photo-1594631252845-29fc45865157?q=80&w=1000&auto=format&fit=crop',
    ),

    // PASTRY
    const Product(
      id: '13',
      name: 'Almond Croissant',
      description: 'Pure French butter croissant filled with sweet almond frangipane cream and topped with toasted sliced almonds. Twice-baked for perfection.',
      price: 4.50,
      rating: 4.9,
      category: 'PASTRY',
      heroTag: 'croissant',
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '14',
      name: 'Blueberry Streusel Muffin',
      description: 'Bursting with fresh local blueberries and finished with a crunchy cinnamon streusel crumble. Moist, flavorful, and baked fresh daily.',
      price: 3.75,
      rating: 4.7,
      category: 'PASTRY',
      heroTag: 'muffin',
      imageUrl: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '15',
      name: 'Double Chocolate Cookie',
      description: 'A decadent treat made with 70% dark Belgian chocolate chunks and a hint of sea salt. Crisp edges with a gooey, molten center.',
      price: 3.25,
      rating: 4.8,
      category: 'PASTRY',
      heroTag: 'cookie',
      imageUrl: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?q=80&w=1000&auto=format&fit=crop',
    ),

    // SPECIALTY
    const Product(
      id: '16',
      name: 'Gold Leaf Affogato',
      description: 'Our luxury special. A double-shot of espresso poured over artisanal vanilla bean gelato, topped with edible 24k gold leaf and crushed hazelnuts.',
      price: 12.00,
      rating: 5.0,
      category: 'SPECIALTY',
      heroTag: 'affogato',
      imageUrl: 'https://images.unsplash.com/photo-1594631252845-29fc45865157?q=80&w=1000&auto=format&fit=crop',
    ),
    const Product(
      id: '17',
      name: 'Smoked Oak Espresso',
      description: 'A sensory experience. Espresso shot pulled through oak-smoked filters, giving the brew a deep, woody aroma and a smooth, savory finish.',
      price: 7.50,
      rating: 4.8,
      category: 'SPECIALTY',
      heroTag: 'smoked_oak',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?q=80&w=1000&auto=format&fit=crop',
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

  List<Map<String, dynamic>> get orders => _orders;
}
