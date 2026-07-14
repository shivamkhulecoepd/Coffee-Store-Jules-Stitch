import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class AddressManagementPage extends StatelessWidget {
  const AddressManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Destinations', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildAddressItem(context, 'Home Office', '421 Espresso Lane, Tech District', true),
            SizedBox(height: 16.h),
            _buildAddressItem(context, 'The Studio', '88 Latte Blvd, Creative Quarter', false),
            SizedBox(height: 32.h),
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location_alt_outlined, color: AppColors.primary, size: 24.sp),
                  SizedBox(width: 16.w),
                  Text('ADD NEW DESTINATION', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                ],
              ),
            ),
            SizedBox(height: 64.h),
            AppButton(text: 'CONFIRM SELECTION', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressItem(BuildContext context, String title, String address, bool isSelected) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      opacity: isSelected ? 1.0 : 0.6,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white10,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on_outlined, color: isSelected ? AppColors.primary : AppColors.outline),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                Text(address, style: AppTypography.bodySmall(context)),
              ],
            ),
          ),
          if (isSelected) Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp),
        ],
      ),
    );
  }
}
