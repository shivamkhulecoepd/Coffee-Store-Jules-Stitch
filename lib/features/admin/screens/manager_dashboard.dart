import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/kpi_card.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAdminDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Executive Control', style: AppTypography.headlineMedium(context)),
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
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.status == AdminStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EXECUTIVE SUMMARY', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2.5)),
                  Text('System Metrics', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                  SizedBox(height: 32.h),
                  _buildKPISection(context, state),
                  SizedBox(height: 40.h),
                  Text('OPERATIONAL ACCESS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                  SizedBox(height: 16.h),
                  _buildAdminOption(context, 'Supply Chain & Inventory', 'inventory', Icons.inventory_2_outlined),
                  _buildAdminOption(context, 'Supplier Infrastructure', 'suppliers', Icons.business_outlined),
                  _buildAdminOption(context, 'System Support Queue', 'requests', Icons.support_agent_outlined),
                  SizedBox(height: 40.h),
                  Text('CRITICAL ALERTS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                  SizedBox(height: 16.h),
                  ...state.alerts.map((a) => _buildInventoryAlert(context, a['item'], a['status'], a['color'] == 'error' ? AppColors.error : Colors.orange)),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKPISection(BuildContext context, AdminState state) {
    return Row(
      children: [
        Expanded(
          child: KPICard(
            label: 'Daily Revenue',
            value: r'$' + state.dailyRevenue.toStringAsFixed(1),
            chartData: const [2.1, 3.5, 2.8, 4.0, 3.2, 4.2],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: KPICard(
            label: 'Avg Basket',
            value: r'$' + state.avgBasket.toStringAsFixed(1),
            chartData: const [15, 17, 16.5, 18, 19, 18.5],
            chartColor: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildAdminOption(BuildContext context, String label, String routeName, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        child: GestureDetector(
          onTap: () => context.pushNamed(routeName),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.primary, size: 20.sp),
              ),
              SizedBox(width: 20.w),
              Expanded(child: Text(label, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w600))),
              Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryAlert(BuildContext context, String item, String status, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.warning_amber_rounded, color: color, size: 20.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(child: Text(item, style: AppTypography.labelMedium(context))),
            Text(status, style: AppTypography.dataMono(context).copyWith(color: color, fontWeight: FontWeight.w800, fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }
}
