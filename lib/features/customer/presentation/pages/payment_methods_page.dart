import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Payment Methods', style: AppTypography.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildCardItem('Visa', '•••• •••• •••• 4242', true),
            SizedBox(height: 16.h),
            _buildCardItem('Mastercard', '•••• •••• •••• 5555', false),
            SizedBox(height: 32.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              height: 72.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: AppColors.primary),
                  SizedBox(width: 12.w),
                  Text('Add New Card', style: AppTypography.labelMedium),
                ],
              ),
            ),
            const Spacer(),
            AppButton(text: 'Save Selection', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(String type, String number, bool isSelected) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.credit_card, color: isSelected ? AppColors.primary : AppColors.outline),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: AppTypography.labelMedium),
                Text(number, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
          ),
          if (isSelected) Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }
}
