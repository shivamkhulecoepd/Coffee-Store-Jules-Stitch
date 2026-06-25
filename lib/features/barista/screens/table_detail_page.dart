import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';
import '../bloc/barista_state.dart';
import '../models/table_session_model.dart';

class TableDetailPage extends StatelessWidget {
  final int tableId;
  const TableDetailPage({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Table #$tableId Detail', style: AppTypography.headlineMedium(context)),
      ),
      body: BlocBuilder<BaristaBloc, BaristaState>(
        builder: (context, state) {
          final session = state.tables.firstWhere((s) => s.tableId == tableId);

          return Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusBanner(context, session),
                SizedBox(height: 32.h),
                Text('ORDER ITEMS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 16.h),
                Expanded(
                  child: session.items.isEmpty
                    ? _buildEmptyItems(context)
                    : ListView.separated(
                        itemCount: session.items.length,
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final item = session.items[index];
                          return _buildItemCard(context, item);
                        },
                      ),
                ),
                _buildFooter(context, session),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, TableSession session) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          _getStatusIcon(session.status),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('STATUS: ${session.status.name.toUpperCase()}', style: AppTypography.labelSmall(context).copyWith(fontWeight: FontWeight.bold)),
              if (session.startTime != null)
                Text('Started at ${session.startTime!.hour}:${session.startTime!.minute.toString().padLeft(2, "0")}',
                     style: AppTypography.bodySmall(context).copyWith(color: AppColors.outline)),
            ],
          ),
          const Spacer(),
          _buildStatusDropdown(context, session),
        ],
      ),
    );
  }

  Widget _getStatusIcon(TableStatus status) {
    switch (status) {
      case TableStatus.vacant: return Icon(Icons.event_seat, color: AppColors.success, size: 24.sp);
      case TableStatus.occupied: return Icon(Icons.person, color: Colors.orange, size: 24.sp);
      case TableStatus.preparing: return Icon(Icons.coffee, color: AppColors.primary, size: 24.sp);
      case TableStatus.readyToBill: return Icon(Icons.receipt, color: Colors.blue, size: 24.sp);
      case TableStatus.completed: return Icon(Icons.check_circle, color: AppColors.success, size: 24.sp);
    }
  }

  Widget _buildStatusDropdown(BuildContext context, TableSession session) {
    return DropdownButton<TableStatus>(
      value: session.status,
      dropdownColor: AppColors.surfaceDark,
      underline: const SizedBox(),
      icon: const Icon(Icons.edit, color: AppColors.primary, size: 16),
      onChanged: (status) {
        if (status != null) {
          context.read<BaristaBloc>().add(UpdateTableStatusEvent(tableId, status));
        }
      },
      items: TableStatus.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name.toUpperCase(), style: TextStyle(fontSize: 10.sp)))).toList(),
    );
  }

  Widget _buildItemCard(BuildContext context, dynamic item) {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(image: NetworkImage(item.product.imageUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.bold)),
                if (item.customization != null)
                  Text(item.customization!, style: AppTypography.bodySmall(context).copyWith(fontSize: 10.sp)),
              ],
            ),
          ),
          Text('x${item.quantity}', style: AppTypography.dataMono(context)),
        ],
      ),
    );
  }

  Widget _buildEmptyItems(BuildContext context) {
    return Center(child: Text('No items in this session.', style: AppTypography.bodyMedium(context)));
  }

  Widget _buildFooter(BuildContext context, TableSession session) {
    if (session.items.isEmpty) return const SizedBox();

    return Column(
      children: [
        const Divider(color: Colors.white10),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL AMOUNT', style: AppTypography.labelSmall(context)),
              Text('\$${session.total.toStringAsFixed(2)}', style: AppTypography.headlineMedium(context).copyWith(color: AppColors.primary)),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'GENERATE BILL',
                onPressed: () {
                  context.read<BaristaBloc>().add(UpdateTableStatusEvent(tableId, TableStatus.readyToBill));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bill generated for table')));
                },
                isPrimary: false,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: AppButton(
                text: 'CLOSE SESSION',
                onPressed: () {
                  context.read<BaristaBloc>().add(CloseTableSessionEvent(tableId));
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
