import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class TableOrderingPage extends StatelessWidget {
  const TableOrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Table 04 Session', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(24.w),
              children: [
                Text('TRANSACTION ITEMS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 20.h),
                _buildOrderItem(context, 'Espresso Doppio', '1', r'.50'),
                _buildOrderItem(context, 'Cappuccino Artisan', '2', r'.50'),
              ],
            ),
          ),
          AppGlassContainer(
            borderRadius: 40.r,
            padding: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, 48.h),
            boxShadow: AppTheme.premiumShadow,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SESSION TOTAL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, letterSpacing: 1)),
                    Text(r'4.00', style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary)),
                  ],
                ),
                SizedBox(height: 32.h),
                AppButton(text: 'AUTHORIZE TRANSMISSION', onPressed: () => context.pop()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String name, String qty, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                Text('UNIT COUNT: $qty', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, fontSize: 10.sp, letterSpacing: 1)),
              ],
            ),
            Text(price, style: AppTypography.dataMono(context).copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
