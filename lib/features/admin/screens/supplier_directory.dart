import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class SupplierDirectoryPage extends StatelessWidget {
  const SupplierDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<StoreRepository>();
    final suppliers = repository.suppliers;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Infrastructure', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: suppliers.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(color: AppColors.surfaceLight, shape: BoxShape.circle),
                  child: Icon(Icons.business, color: AppColors.primary, size: 24.sp),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(supplier['name'], style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                      Text('Logistics: ${supplier['status']} • ${supplier['location']}', style: AppTypography.bodySmall(context).copyWith(color: AppColors.success)),
                    ],
                  ),
                ),
                Icon(Icons.call_outlined, color: AppColors.primary, size: 20.sp),
              ],
            ),
          );
        },
      ),
    );
  }
}
