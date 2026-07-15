import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_state.dart';
import '../models/table_session_model.dart';

class ActiveTablesBillingPage extends StatelessWidget {
  const ActiveTablesBillingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<BaristaBloc, BaristaState>(
        // Rebuilds automatically when table stream emits
        builder: (context, state) {
          final activeTables = state.tables
              .where((t) =>
                  t.status == TableStatus.occupied ||
                  t.status == TableStatus.readyToBill ||
                  t.status == TableStatus.preparing)
              .toList();

          if (activeTables.isEmpty) {
            return Center(
              child: Text('No active tables.',
                  style: AppTypography.bodySmall(context)),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(20.w),
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
                        Text('TABLE #${table.tableId}',
                            style: AppTypography.labelSmall(context)),
                        Text('Active Session',
                            style: AppTypography.bodySmall(context)),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$${table.total.toStringAsFixed(2)}',
                      style: AppTypography.dataMono(context)
                          .copyWith(color: AppColors.primary),
                    ),
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
