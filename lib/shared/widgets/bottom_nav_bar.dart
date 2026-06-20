import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'glass_container.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<AppBottomNavItem> items;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassContainer(
      height: 80.h,
      width: double.infinity,
      borderRadius: 0,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) => _buildNavItem(context, index)),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final item = items[index];
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: isActive ? AppColors.primary : AppColors.outline,
              size: 28.sp,
            ),
            if (isActive)
              Container(
                margin: EdgeInsets.only(top: 4.h),
                width: 4.w,
                height: 4.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppBottomNavItem {
  final IconData icon;
  final String label;
  const AppBottomNavItem({required this.icon, required this.label});
}
