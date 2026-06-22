import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class InventoryStatusPage extends StatelessWidget {
  const InventoryStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<StoreRepository>();
    final inventory = repository.inventory;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Inventory Status', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart, color: AppColors.primary),
            onPressed: () => context.pushNamed('purchase'),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: inventory.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final item = inventory[index];
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ITEM #${item['id']}', style: AppTypography.dataMono(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
                      Text(item['name'], style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                      SizedBox(height: 12.h),
                      _buildStockBar(item['progress']),
                    ],
                  ),
                ),
                SizedBox(width: 24.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item['qty'], style: AppTypography.headlineMedium(context)),
                    Text(item['progress'] < 0.3 ? 'LOW STOCK' : 'HEALTHY',
                      style: AppTypography.labelSmall(context).copyWith(
                        color: item['progress'] < 0.3 ? Colors.orange : AppColors.success,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStockBar(double progress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 4.h,
        backgroundColor: Colors.white10,
        color: progress < 0.3 ? AppColors.error : AppColors.primary,
      ),
    );
  }
}
