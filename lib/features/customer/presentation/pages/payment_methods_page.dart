import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
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
        title: Text('Wallet', style: AppTypography.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildCardItem('Visa Credit', '•••• •••• •••• 4242', true),
            SizedBox(height: 20.h),
            _buildCardItem('Mastercard', '•••• •••• •••• 5555', false),
            SizedBox(height: 40.h),
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              height: 72.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 16.w),
                  Text('LINK NEW CARD', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2)),
                ],
              ),
            ),
            const Spacer(),
            AppButton(text: 'SAVE PREFERENCES', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(String type, String number, bool isSelected) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      boxShadow: isSelected ? AppTheme.premiumShadow : null,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.surfaceSecondary, shape: BoxShape.circle),
            child: Icon(Icons.credit_card, color: isSelected ? AppColors.primary : AppColors.outline),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.toUpperCase(), style: AppTypography.labelSmall.copyWith(color: AppColors.outline, fontSize: 10.sp)),
                Text(number, style: AppTypography.dataMono.copyWith(fontSize: 16.sp)),
              ],
            ),
          ),
          if (isSelected) Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp),
        ],
      ),
    );
  }
}
