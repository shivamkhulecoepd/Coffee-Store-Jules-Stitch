import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Checkout', style: AppTypography.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Delivery Address'),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Home', style: AppTypography.labelMedium),
                        Text('123 Coffee Lane, Barista City, 54321', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  Icon(Icons.edit_outlined, color: AppColors.outline, size: 20.sp),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Payment Method'),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 16.w),
                  Text('•••• •••• •••• 4242', style: AppTypography.labelMedium),
                  const Spacer(),
                  Icon(Icons.keyboard_arrow_right, color: AppColors.outline),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Order Summary'),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _buildPriceRow('Vanilla Latte (x2)', r'1.00'),
                  _buildPriceRow('Delivery', r'.50'),
                  const Divider(color: AppColors.surfaceSecondary),
                  _buildPriceRow('Total', r'2.50', isBold: true),
                ],
              ),
            ),
            SizedBox(height: 48.h),
            AppButton(
              text: 'Place Order',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.primary));
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? AppTypography.labelMedium : AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
          Text(value, style: isBold ? AppTypography.labelMedium.copyWith(color: AppColors.primary) : AppTypography.labelMedium),
        ],
      ),
    );
  }
}
