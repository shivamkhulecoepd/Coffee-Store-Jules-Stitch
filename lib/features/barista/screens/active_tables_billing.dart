import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class ActiveTablesBillingPage extends StatelessWidget {
  const ActiveTablesBillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<StoreRepository>();
    final activeTables = repository.tables.where((t) => t['status'] == 'Occupied').toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Table Billing', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: activeTables.isEmpty
          ? Center(child: Text('No active tables.', style: AppTypography.bodySmall(context)))
          : ListView.separated(
              padding: EdgeInsets.all(24.w),
              itemCount: activeTables.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final table = activeTables[index];
                return AppGlassContainer(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TABLE #${table['id']}', style: AppTypography.labelSmall(context)),
                          Text('Active Session', style: AppTypography.bodySmall(context)),
                        ],
                      ),
                      const Spacer(),
                      Text(r'$' + table['total'].toStringAsFixed(2), style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
