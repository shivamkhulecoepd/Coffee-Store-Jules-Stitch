import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/glass_container.dart';

class PurchaseOrderPage extends StatelessWidget {
  const PurchaseOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Create Purchase Order', style: AppTypography.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Supplier', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
            SizedBox(height: 8.h),
            AppGlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 56.h,
              borderRadius: 12.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Premium Bean Roasters Co.', style: AppTypography.bodyMedium),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.outline),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Text('Items', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
            SizedBox(height: 16.h),
            _buildOrderItem('Arabica Light Roast', '10kg', r'50.00'),
            _buildOrderItem('Paper Cups (12oz)', '500 units', r'5.00'),
            const Spacer(),
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated Total', style: AppTypography.labelMedium),
                      Text(r'95.00', style: AppTypography.headlineMedium.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  AppButton(text: 'Submit Purchase Order', onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String qty, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium),
                  Text(qty, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            Text(price, style: AppTypography.labelMedium),
          ],
        ),
      ),
    );
  }
}
