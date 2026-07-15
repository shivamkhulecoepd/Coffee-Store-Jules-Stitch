import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';
import '../bloc/barista_state.dart';
import '../models/table_session_model.dart';

class TableOrderingPage extends StatelessWidget {
  /// Pass tableId via extra: {'tableId': 4}
  final Map<String, dynamic>? data;

  const TableOrderingPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final int tableId = data?['tableId'] ?? 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Table $tableId Session', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<BaristaBloc, BaristaState>(
        builder: (context, state) {
          // Load session from BaristaBloc state (live via repository stream)
          TableSession? session;
          try {
            session = state.tables.firstWhere((s) => s.tableId == tableId);
          } catch (_) {
            session = null;
          }

          final items = session?.items ?? [];
          final total = session?.total ?? 0.0;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20.w),
                  children: [
                    Text('TRANSACTION ITEMS',
                        style: AppTypography.labelSmall(context)
                            .copyWith(color: AppColors.primary, letterSpacing: 2)),
                    SizedBox(height: 20.h),
                    if (items.isEmpty)
                      AppGlassContainer(
                        padding: EdgeInsets.all(20.w),
                        child: Center(
                          child: Text('No items in this session yet.',
                              style: AppTypography.bodySmall(context)),
                        ),
                      )
                    else
                      ...items.map((item) => _buildOrderItem(
                            context,
                            item.product.name,
                            '${item.quantity}',
                            r'$' + (item.product.price * item.quantity).toStringAsFixed(2),
                          )),
                  ],
                ),
              ),
              AppGlassContainer(
                borderRadius: 40.r,
                padding: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, 48.h),
                boxShadow: AppTheme.premiumShadow,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SESSION TOTAL',
                            style: AppTypography.labelSmall(context)
                                .copyWith(color: AppColors.outline, letterSpacing: 1)),
                        Text('\$${total.toStringAsFixed(2)}',
                            style: AppTypography.headlineLarge(context)
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    AppButton(
                      text: 'AUTHORIZE TRANSMISSION',
                      onPressed: () {
                        // Mark all items as preparing — update table status
                        context.read<BaristaBloc>()
                            .add(UpdateTableStatusEvent(tableId, TableStatus.preparing));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order Sent to Brewing Station')),
                        );
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(
      BuildContext context, String name, String qty, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: AppTypography.labelMedium(context)
                        .copyWith(fontWeight: FontWeight.w700)),
                Text('UNIT COUNT: $qty',
                    style: AppTypography.labelSmall(context)
                        .copyWith(color: AppColors.primary, fontSize: 10.sp, letterSpacing: 1)),
              ],
            ),
            Text(price, style: AppTypography.dataMono(context).copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
