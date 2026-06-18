import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class TableOrderingPage extends StatelessWidget {
  const TableOrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Table 4 Ordering', style: AppTypography.headlineMedium),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _buildOrderItem('Espresso', '1'),
                _buildOrderItem('Cappuccino', '2'),
              ],
            ),
          ),
          AppGlassContainer(
            borderRadius: 0,
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTypography.headlineMedium),
                    Text(r'4.00', style: AppTypography.headlineMedium.copyWith(color: AppColors.primary)),
                  ],
                ),
                SizedBox(height: 24.h),
                AppButton(text: 'Send to Kitchen', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, String qty) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: AppTypography.labelMedium),
            Text('x'+qty, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
