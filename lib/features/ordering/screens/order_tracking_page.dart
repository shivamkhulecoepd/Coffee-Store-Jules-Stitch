import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class OrderTrackingPage extends StatelessWidget {
  final Map<String, dynamic>? orderData;

  const OrderTrackingPage({super.key, this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Order Journey', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ESTIMATED ARRIVAL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
                          Text('10:45 AM', style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8.r)),
                        child: Text('ON TIME', style: AppTypography.labelSmall(context).copyWith(color: AppColors.success, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  _buildTrackStep(context, 'Order Placed', 'Your request has been received.', true, true),
                  _buildTrackStep(context, 'Baking & Brewing', 'Our barista is crafting your selection.', true, true),
                  _buildTrackStep(context, 'Quality Check', 'Verifying aroma and texture profiles.', true, false),
                  _buildTrackStep(context, 'Ready for Pickup', 'Your artisanal brew is at the counter.', false, false),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Text('SEQUENCE DETAILS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                   _buildDetailRow('Session ID', orderData?['id'] ?? '#ST-9021'),
                   _buildDetailRow('Items', orderData?['items'] ?? 'Signature Vanilla Latte'),
                   _buildDetailRow('Total', '\$${orderData?['total']?.toStringAsFixed(2) ?? '6.50'}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackStep(BuildContext context, String title, String subtitle, bool isCompleted, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.primary : Colors.transparent,
                  border: Border.all(color: isCompleted ? AppColors.primary : AppColors.outline.withValues(alpha: 0.3)),
                  shape: BoxShape.circle,
                ),
                child: isCompleted ? Icon(Icons.check, size: 14.sp, color: AppColors.onPrimary) : null,
              ),
              if (isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: isCompleted ? AppColors.primary : AppColors.outline.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700, color: isCompleted ? Colors.white : AppColors.outline)),
                  Text(subtitle, style: AppTypography.bodySmall(context).copyWith(fontSize: 12.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.outline)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
