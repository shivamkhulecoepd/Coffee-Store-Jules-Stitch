import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class InventoryStatusPage extends StatelessWidget {
  const InventoryStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Inventory Status', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildInventoryCategory('Coffee Beans'),
          _buildInventoryItem('Arabica Light Roast', '25kg', 0.8),
          _buildInventoryItem('Dark Roast Blend', '12kg', 0.4),
          SizedBox(height: 32.h),
          _buildInventoryCategory('Dairy & Alternatives'),
          _buildInventoryItem('Whole Milk', '45L', 0.9),
          _buildInventoryItem('Oat Milk', '15L', 0.3),
        ],
      ),
    );
  }

  Widget _buildInventoryCategory(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
    );
  }

  Widget _buildInventoryItem(String name, String stock, double percentage) {
    Color color = percentage > 0.5 ? Colors.green : (percentage > 0.3 ? Colors.orange : Colors.red);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: AppTypography.labelMedium),
                Text(stock, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.surfaceSecondary,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ],
        ),
      ),
    );
  }
}
