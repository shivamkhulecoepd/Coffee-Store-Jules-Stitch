import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class CustomizeBrewPage extends StatelessWidget {
  const CustomizeBrewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Calibration', style: AppTypography.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('MILK ALTERNATIVE', ['WHOLE', 'OAT', 'ALMOND', 'SOY']),
            SizedBox(height: 40.h),
            _buildSection('EXTRACTION STRENGTH', ['0%', '25%', '50%', '75%', '100%']),
            SizedBox(height: 40.h),
            _buildSection('TEMPERATURE', ['HOT', 'ICED', 'EXTRA HOT']),
            SizedBox(height: 40.h),
            _buildSection('ADDITIONAL NOTES', ['EXTRA SHOT', 'DRIZZLE', 'FOAM']),
            SizedBox(height: 64.h),
            AppButton(text: 'APPLY CONFIGURATION', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2)),
        SizedBox(height: 20.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: options.map((opt) => _buildOptionChip(opt, opt == options[1])).toList(),
        ),
      ],
    );
  }

  Widget _buildOptionChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceSecondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.white10),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    );
  }
}
