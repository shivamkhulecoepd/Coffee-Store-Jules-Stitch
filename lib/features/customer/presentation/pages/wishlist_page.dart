import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Wishlist', style: AppTypography.headlineMedium),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 2,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildWishlistItem();
        },
      ),
    );
  }

  Widget _buildWishlistItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.favorite, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ethiopian Blend', style: AppTypography.labelMedium),
                Text('Specialty Roast', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
          ),
          Icon(Icons.add_shopping_cart, color: AppColors.primary),
        ],
      ),
    );
  }
}
