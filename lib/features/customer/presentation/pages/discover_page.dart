import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Discover', style: AppTypography.headlineMedium),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 56.h,
              borderRadius: 16.r,
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.outline, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text('Search for your favorite brew...', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Brewing Methods'),
            SizedBox(height: 16.h),
            _buildBrewingMethodGrid(),
            SizedBox(height: 32.h),
            _buildSectionHeader('New Arrivals'),
            SizedBox(height: 16.h),
            _buildArrivalsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.headlineMedium),
        Text('See All', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
      ],
    );
  }

  Widget _buildBrewingMethodGrid() {
    final methods = [
      {'name': 'Pour Over', 'icon': Icons.water_drop_outlined},
      {'name': 'French Press', 'icon': Icons.coffee_maker_outlined},
      {'name': 'Cold Drip', 'icon': Icons.ac_unit_outlined},
      {'name': 'AeroPress', 'icon': Icons.compress_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.5,
      ),
      itemCount: methods.length,
      itemBuilder: (context, index) {
        return AppGlassContainer(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(methods[index]['icon'] as IconData, color: AppColors.primary, size: 24.sp),
              SizedBox(height: 8.h),
              Text(methods[index]['name'] as String, style: AppTypography.labelMedium),
            ],
          ),
        );
      },
    );
  }

  Widget _buildArrivalsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AppGlassContainer(
          padding: EdgeInsets.all(16.w),
          height: 100.h,
          child: Row(
            children: [
              Container(
                width: 68.w,
                height: 68.h,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(Icons.coffee_bean_outlined, color: AppColors.primary),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ethiopian Yirgacheffe', style: AppTypography.labelMedium),
                    Text('Floral, Lemon, Berry notes', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                  ],
                ),
              ),
              Text(r'8.00', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
            ],
          ),
        );
      },
    );
  }
}
