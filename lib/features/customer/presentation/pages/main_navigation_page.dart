import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../core/providers/navigation_provider.dart';
import 'home_page.dart';
import 'discover_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    DiscoverPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navProvider, child) {
        return Scaffold(
          extendBody: true, // This is crucial for glassmorphism
          body: IndexedStack(
            index: navProvider.currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: navProvider.currentIndex,
            onTap: (index) {
              navProvider.setIndex(index);
            },
          ),
        );
      },
    );
  }
}
