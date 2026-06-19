import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Curated List', style: AppTypography.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 2,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          return _buildWishlistItem();
        },
      ),
    );
  }

  Widget _buildWishlistItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.favorite, color: AppColors.primary, size: 32.sp),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ethiopian Yirgacheffe', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600)),
                Text('Single Origin • Specialty', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Text(r'2.00', style: AppTypography.dataMono.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          AppGlassContainer(
            width: 44.w,
            height: 44.w,
            borderRadius: 12.r,
            padding: EdgeInsets.zero,
            child: Center(child: Icon(Icons.add_shopping_cart, color: AppColors.primary, size: 20.sp)),
          ),
        ],
      ),
    );
  }
}
