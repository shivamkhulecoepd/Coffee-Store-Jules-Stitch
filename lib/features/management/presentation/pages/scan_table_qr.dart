import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ScanTableQRPage extends StatelessWidget {
  const ScanTableQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Scan Table QR', style: AppTypography.headlineMedium),
      ),
      body: Column(
        children: [
          SizedBox(height: 64.h),
          Center(
            child: AppGlassContainer(
              width: 280.w,
              height: 280.w,
              borderRadius: 40.r,
              padding: EdgeInsets.all(40.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Icon(Icons.qr_code_scanner, size: 100.sp, color: AppColors.primary),
                ),
              ),
            ),
          ),
          SizedBox(height: 48.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Align the table QR code within the frame to start a new order session.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularAction(Icons.flash_on),
                SizedBox(width: 32.w),
                _buildCircularAction(Icons.history),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularAction(IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primary, size: 24.sp),
    );
  }
}
