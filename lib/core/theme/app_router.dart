import 'package:flutter/material.dart';
import '../../features/auth/screens/welcome_page.dart';
import '../../features/auth/screens/login_page.dart';
import '../../features/ordering/screens/home_page.dart';
import '../../features/ordering/screens/discover_page.dart';
import '../../features/ordering/screens/cart_page.dart';
import '../../features/ordering/screens/product_details_page.dart';
import '../../features/ordering/screens/checkout_page.dart';
import '../../features/ordering/screens/order_confirmed_page.dart';
import '../../features/barista/screens/barista_dashboard.dart';

class AppRouter {
  static const String welcome = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String discover = '/discover';
  static const String cart = '/cart';
  static const String productDetails = '/details';
  static const String checkout = '/checkout';
  static const String orderConfirmed = '/confirmed';
  static const String baristaDashboard = '/barista';

  static Map<String, WidgetBuilder> get routes => {
    welcome: (context) => const WelcomePage(),
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
    discover: (context) => const DiscoverPage(),
    cart: (context) => const CartPage(),
    productDetails: (context) => const ProductDetailsPage(),
    checkout: (context) => const CheckoutPage(),
    orderConfirmed: (context) => const OrderConfirmedPage(),
    baristaDashboard: (context) => const BaristaDashboard(),
  };
}
