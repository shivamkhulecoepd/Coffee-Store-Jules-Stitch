import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class SupplierDirectoryPage extends StatelessWidget {
  const SupplierDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Supplier Directory', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSupplierCard('Premium Bean Roasters', 'Coffee Beans', 'Active'),
          _buildSupplierCard('Dairy Fresh Solutions', 'Milk & Cream', 'Active'),
          _buildSupplierCard('EcoPack Supplies', 'Packaging', 'Review Needed'),
          _buildSupplierCard('Pastry Palace', 'Baked Goods', 'Active'),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(String name, String category, String status) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.business_outlined, color: AppColors.primary),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium),
                  Text(category, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            Text(
              status,
              style: AppTypography.labelSmall.copyWith(
                color: status == 'Active' ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
