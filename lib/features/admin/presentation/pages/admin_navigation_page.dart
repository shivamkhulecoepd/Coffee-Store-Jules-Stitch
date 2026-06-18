import 'package:flutter/material.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../core/theme/app_colors.dart';
import 'manager_dashboard.dart';
import 'inventory_status.dart';
import 'customer_requests.dart';
import 'supplier_directory.dart';

class AdminNavigationPage extends StatefulWidget {
  const AdminNavigationPage({super.key});

  @override
  State<AdminNavigationPage> createState() => _AdminNavigationPageState();
}

class _AdminNavigationPageState extends State<AdminNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ManagerDashboard(),
    InventoryStatusPage(),
    CustomerRequestsPage(),
    SupplierDirectoryPage(),
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
            _buildNavItem(Icons.admin_panel_settings_outlined, 'Home', 0),
            _buildNavItem(Icons.inventory_2_outlined, 'Stock', 1),
            _buildNavItem(Icons.support_agent_outlined, 'Support', 2),
            _buildNavItem(Icons.business_outlined, 'Suppliers', 3),
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
