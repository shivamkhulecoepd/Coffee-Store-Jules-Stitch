import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';

class TableLayoutPage extends StatelessWidget {
  const TableLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Floor Layout', style: AppTypography.headlineMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(24.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 24.h,
          crossAxisSpacing: 24.w,
          childAspectRatio: 0.9,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          bool isOccupied = index % 4 == 0;
          return _buildTableItem(context, index + 1, isOccupied);
        },
      ),
    );
  }

  Widget _buildTableItem(BuildContext context, int number, bool isOccupied) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/ordering'),
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        borderRadius: 20.r,
        boxShadow: isOccupied ? null : AppTheme.premiumShadow,
        opacity: isOccupied ? 0.3 : 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('T$number', style: AppTypography.headlineMedium.copyWith(color: isOccupied ? AppColors.outline : Colors.white)),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isOccupied ? AppColors.primary.withOpacity(0.1) : AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                isOccupied ? 'BUSY' : 'OPEN',
                style: AppTypography.labelSmall.copyWith(
                  color: isOccupied ? AppColors.primary : AppColors.success,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
