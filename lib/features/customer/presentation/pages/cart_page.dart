import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Your Cart', style: AppTypography.headlineMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: 2,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return _buildCartItem();
              },
            ),
          ),
          _buildSummarySection(context),
        ],
      ),
    );
  }

  Widget _buildCartItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      height: 120.h,
      child: Row(
        children: [
          Container(
            width: 88.w,
            height: 88.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.coffee, color: AppColors.primary, size: 40.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Vanilla Latte', style: AppTypography.labelMedium),
                Text('Medium, Oat Milk', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                SizedBox(height: 8.h),
                Text(r'.50', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQtyBtn(Icons.add),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text('1', style: AppTypography.labelMedium),
              ),
              _buildQtyBtn(Icons.remove),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Icon(icon, size: 16.sp, color: AppColors.primary),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return AppGlassContainer(
      borderRadius: 0,
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', r'1.00'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Delivery Fee', r'.50'),
          SizedBox(height: 16.h),
          const Divider(color: AppColors.surfaceSecondary),
          SizedBox(height: 16.h),
          _buildSummaryRow('Total', r'2.50', isTotal: true),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Checkout',
            onPressed: () => Navigator.pushNamed(context, '/checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTotal ? AppTypography.headlineMedium : AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
        Text(value, style: isTotal ? AppTypography.headlineMedium.copyWith(color: AppColors.primary) : AppTypography.labelMedium),
      ],
    );
  }
}
