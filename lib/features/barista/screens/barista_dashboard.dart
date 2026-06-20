import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/kpi_card.dart';

class BaristaDashboard extends StatelessWidget {
  const BaristaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Barista Control', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () => context.goNamed('welcome'),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SYSTEM STATUS: ONLINE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.success, letterSpacing: 2)),
                        Text('Sarah Miller', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  _buildStatusIndicator(),
                ],
              ),
              SizedBox(height: 32.h),
              _buildKPISection(context),
              SizedBox(height: 40.h),
              Text('OPERATIONS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
              SizedBox(height: 16.h),
              _buildQuickActions(context),
              SizedBox(height: 40.h),
              Text('ACTIVE EXTRACTIONS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
              SizedBox(height: 16.h),
              _buildActiveOrdersList(context),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Container(
          width: 12.w,
          height: 12.w,
          decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildKPISection(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: KPICard(
            label: 'Total Orders',
            value: '24',
            chartData: [10, 15, 12, 18, 20, 24],
          ),
        ),
        SizedBox(width: 16.w),
        const Expanded(
          child: KPICard(
            label: 'Avg. Latency',
            value: '4m',
            chartData: [5, 4.5, 4.2, 4.8, 4.1, 4.0],
            chartColor: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(context, Icons.qr_code_scanner, 'Scan QR', 'scan'),
        _buildActionItem(context, Icons.history, 'Shift Info', 'overview'),
        _buildActionItem(context, Icons.receipt_long, 'Billing', 'billing'),
        _buildActionItem(context, Icons.assignment_turned_in, 'Handover', 'handover'),
      ],
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String label, String routeName) {
    return GestureDetector(
      onTap: () => context.pushNamed(routeName),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          AppGlassContainer(
            width: 68.w,
            height: 68.w,
            borderRadius: 20.r,
            padding: EdgeInsets.zero,
            child: Center(child: Icon(icon, color: AppColors.primary, size: 24.sp)),
          ),
          SizedBox(height: 12.h),
          Text(label, style: AppTypography.labelSmall(context).copyWith(fontSize: 10.sp, fontWeight: FontWeight.w600, letterSpacing: 0)),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.pushNamed('brewing'),
          behavior: HitTestBehavior.opaque,
          child: AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SESSION #421', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontSize: 10.sp)),
                      Text('2x Vanilla Latte', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                      Text('Table 4 • Synchronizing', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 11.sp)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6.r)),
                  child: Text('BREWING', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, fontSize: 9.sp, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
