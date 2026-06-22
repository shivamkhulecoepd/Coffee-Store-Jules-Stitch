import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../ordering/bloc/ordering_bloc.dart';
import '../../ordering/bloc/ordering_state.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Archive', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          if (state.orderHistory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80.sp, color: AppColors.outline.withOpacity(0.3)),
                  SizedBox(height: 24.h),
                  Text('No orders found.', style: AppTypography.bodyLarge(context).copyWith(color: AppColors.outline)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: state.orderHistory.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final order = state.orderHistory[index];
              return AppGlassContainer(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order['id'], style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontSize: 10.sp)),
                          Text(order['items'], style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${order['date']} • ${order['status']}', style: AppTypography.bodySmall(context)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(r'$' + order['total'].toStringAsFixed(2), style: AppTypography.dataMono(context).copyWith(fontWeight: FontWeight.w800)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
