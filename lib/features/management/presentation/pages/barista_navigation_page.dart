import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../core/theme/app_colors.dart';
import 'barista_dashboard.dart';
import 'table_layout.dart';
import 'operational_tasks.dart';
import 'barista_performance.dart';

class BaristaNavigationPage extends StatefulWidget {
  const BaristaNavigationPage({super.key});

  @override
  State<BaristaNavigationPage> createState() => _BaristaNavigationPageState();
}

class _BaristaNavigationPageState extends State<BaristaNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BaristaDashboard(),
    TableLayoutPage(),
    OperationalTasksPage(),
    BaristaPerformancePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppGlassContainer(
        height: 80,
        borderRadius: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.dashboard_outlined, 'Status', 0),
            _buildNavItem(Icons.table_restaurant_outlined, 'Tables', 1),
            _buildNavItem(Icons.checklist_rtl_outlined, 'Tasks', 2),
            _buildNavItem(Icons.analytics_outlined, 'Stats', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? AppColors.primary : AppColors.outline, size: 28),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
