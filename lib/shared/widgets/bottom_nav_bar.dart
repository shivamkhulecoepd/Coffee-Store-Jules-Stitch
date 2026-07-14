import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

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
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.8),
        border: const Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final int idx = entry.key;
              final AppBottomNavItem item = entry.value;
              final bool isSelected = currentIndex == idx;

              return GestureDetector(
                onTap: () => onTap(idx),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected ? AppColors.primary : AppColors.outline,
                      size: 28.sp,
                    ),
                    if (isSelected)
                      Container(
                        margin: EdgeInsets.only(top: 6.h),
                        width: 4.w,
                        height: 4.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
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
