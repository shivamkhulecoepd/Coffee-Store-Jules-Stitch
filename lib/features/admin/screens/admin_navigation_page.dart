import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../core/theme/app_colors.dart';
import 'manager_dashboard.dart';
import 'inventory_status.dart';
import 'customer_requests.dart';
import 'product_management.dart';

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
    ProductManagementPage(),
    CustomerRequestsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppGlassContainer(
        height: 90.h,
        width: double.infinity,
        borderRadius: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.analytics_outlined, 'Metrics', 0),
            _buildNavItem(Icons.inventory_2_outlined, 'Stock', 1),
            _buildNavItem(Icons.coffee_outlined, 'Catalog', 2),
            _buildNavItem(Icons.support_agent_outlined, 'Queue', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? AppColors.primary : AppColors.outline, size: 28.sp),
          if (isActive)
            Container(
              margin: EdgeInsets.only(top: 6.h),
              width: 5.w,
              height: 5.w,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
