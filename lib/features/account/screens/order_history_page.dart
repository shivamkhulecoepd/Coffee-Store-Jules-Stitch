import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Transaction History', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          return _buildHistoryItem(context);
        },
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: AppColors.surfaceDark, borderRadius: BorderRadius.circular(12.r)),
            child: Icon(Icons.receipt_long, color: AppColors.primary, size: 24.sp),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ORDER #BRW-1234', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontSize: 10.sp)),
                Text('Vanilla Latte x2', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w600)),
                Text('Oct 24, 2023 • 10:30 AM', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(r'2.50', style: AppTypography.dataMono(context).copyWith(fontWeight: FontWeight.w700)),
              Text('DELIVERED', style: AppTypography.labelSmall(context).copyWith(color: AppColors.success, fontSize: 10.sp, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}
