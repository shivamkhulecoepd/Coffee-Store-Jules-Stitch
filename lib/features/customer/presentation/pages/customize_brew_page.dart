import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';

class CustomizeBrewPage extends StatelessWidget {
  const CustomizeBrewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Customize Your Brew', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomizationSection('Milk Options', ['Whole', 'Oat', 'Almond', 'Soy']),
            SizedBox(height: 32.h),
            _buildCustomizationSection('Sweetness', ['0%', '25%', '50%', '75%', '100%']),
            SizedBox(height: 32.h),
            _buildCustomizationSection('Temperature', ['Hot', 'Iced', 'Extra Hot']),
            SizedBox(height: 32.h),
            _buildCustomizationSection('Add-ons', ['Extra Shot', 'Caramel Drizzle', 'Whipped Cream']),
            SizedBox(height: 48.h),
            AppButton(text: 'Apply Customization', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomizationSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
        SizedBox(height: 16.h),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
        ),
      ),
    );
  }
}
