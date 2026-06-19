import 'package:flutter/material.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'discover_page.dart';
import 'cart_page.dart';
import '../../account/screens/profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    DiscoverPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          AppBottomNavItem(icon: Icons.home_filled, label: 'Home'),
          AppBottomNavItem(icon: Icons.search, label: 'Discover'),
          AppBottomNavItem(icon: Icons.shopping_bag_outlined, label: 'Cart'),
          AppBottomNavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }
}
