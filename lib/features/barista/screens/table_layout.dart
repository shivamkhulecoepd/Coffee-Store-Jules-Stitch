import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';
import '../bloc/barista_state.dart';
import '../models/table_session_model.dart';

class TableLayoutPage extends StatefulWidget {
  const TableLayoutPage({super.key});

  @override
  State<TableLayoutPage> createState() => _TableLayoutPageState();
}

class _TableLayoutPageState extends State<TableLayoutPage> {
  @override
  void initState() {
    super.initState();
    context.read<BaristaBloc>().add(LoadBaristaDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Table Logic', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<BaristaBloc, BaristaState>(
        builder: (context, state) {
          if (state.status == BaristaStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          return GridView.builder(
            padding: EdgeInsets.all(20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: 1.1,
            ),
            itemCount: state.tables.length,
            itemBuilder: (context, index) {
              final table = state.tables[index];
              final bool isOccupied = table.status == TableStatus.occupied;

              return GestureDetector(
                onTap: () => context.pushNamed('ordering', extra: {'table': table.tableId}),
                child: AppGlassContainer(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('TABLE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
                      Text('${table.tableId}', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w800)),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: (isOccupied ? AppColors.error : AppColors.success).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          table.status.name.toUpperCase(),
                          style: AppTypography.labelSmall(context).copyWith(
                            color: isOccupied ? AppColors.error : AppColors.success,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
