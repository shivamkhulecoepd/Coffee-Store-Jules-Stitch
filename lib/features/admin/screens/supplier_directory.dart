import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

class SupplierDirectoryPage extends StatelessWidget {
  const SupplierDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Suppliers', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildSupplierCard(context, 'Premium Bean Roasters', 'Specialty Beans', 'TRUSTED', AppColors.success),
          _buildSupplierCard(context, 'Dairy Fresh Solutions', 'Milk & Cream', 'TRUSTED', AppColors.success),
          _buildSupplierCard(context, 'EcoPack Supplies', 'Bio-Degradable', 'REVIEW', Colors.orange),
          _buildSupplierCard(context, 'Pastry Palace', 'Baked Goods', 'TRUSTED', AppColors.success),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(BuildContext context, String name, String category, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Icon(Icons.business_outlined, color: AppColors.primary, size: 28.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w800)),
                  Text(category, style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4.r)),
              child: Text(status, style: AppTypography.labelSmall(context).copyWith(color: statusColor, fontSize: 10.sp, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}
