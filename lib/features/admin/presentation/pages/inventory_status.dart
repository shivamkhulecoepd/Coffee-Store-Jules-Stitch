import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';

class InventoryStatusPage extends StatelessWidget {
  const InventoryStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Supply Chain', style: AppTypography.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildInventoryCategory('BEAN RESERVES'),
          _buildInventoryItem('Arabica Light Roast', '25kg', 0.8),
          _buildInventoryItem('Dark Roast Espresso', '12kg', 0.35),
          SizedBox(height: 40.h),
          _buildInventoryCategory('DAIRY & ALTERNATIVES'),
          _buildInventoryItem('Whole A2 Milk', '45L', 0.9),
          _buildInventoryItem('Oat Professional', '15L', 0.2),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildInventoryCategory(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Text(title, style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2)),
    );
  }

  Widget _buildInventoryItem(String name, String stock, double percentage) {
    Color color = percentage > 0.5 ? AppColors.success : (percentage > 0.3 ? Colors.orange : AppColors.error);
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(24.w),
        boxShadow: AppTheme.premiumShadow,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(stock, style: AppTypography.dataMono.copyWith(color: AppColors.primary)),
              ],
            ),
            SizedBox(height: 20.h),
            Stack(
              children: [
                Container(
                  height: 6.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3.r)),
                ),
                Container(
                  height: 6.h,
                  width: (ScreenUtil().screenWidth - 96.w) * percentage,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3.r),
                    boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, spreadRadius: 1)],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
