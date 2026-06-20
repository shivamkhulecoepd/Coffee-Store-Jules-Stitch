import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

class ScanTableQRPage extends StatelessWidget {
  const ScanTableQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Scan Table QR', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Center(
              child: AppGlassContainer(
                width: 300.w,
                height: 300.w,
                borderRadius: 40.r,
                boxShadow: AppTheme.premiumShadow,
                child: Container(
                  margin: EdgeInsets.all(40.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Center(
                    child: Icon(Icons.qr_code_scanner, size: 100.sp, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Text(
                'Align the table QR code within the frame to synchronize the local station with the cloud session.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.5),
              ),
            ),
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.all(40.w),
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
      ),
    );
  }

  Widget _buildCircularAction(IconData icon) {
    return AppGlassContainer(
      width: 64.w,
      height: 64.w,
      borderRadius: 32.r,
      shape: BoxShape.circle,
      child: Center(child: Icon(icon, color: AppColors.primary, size: 24.sp)),
    );
  }
}
