import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';
import '../bloc/barista_state.dart';
import '../models/table_session_model.dart';

class ScanTableQRPage extends StatelessWidget {
  const ScanTableQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Scan Table QR', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<BaristaBloc, BaristaState>(
        listener: (context, state) {
          // After a successful scan, navigate to table detail
          if (state.scannedTableId != null && state.scanError == null) {
            context.pushNamed('table-detail', extra: {'tableId': state.scannedTableId});
          }
          if (state.scanError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.scanError}')),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 80.h),
              Center(
                child: AppGlassContainer(
                  width: 300.w,
                  height: 300.w,
                  borderRadius: 40.r,
                  boxShadow: AppTheme.premiumShadow,
                  child: InkWell(
                    onTap: () => _simulateScan(context),
                    child: Container(
                      margin: EdgeInsets.all(40.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: Icon(Icons.qr_code_scanner,
                            size: 100.sp, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Text(
                  'Align the table QR code within the frame to synchronize the local station with the cloud session.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(context)
                      .copyWith(color: AppColors.outline, height: 1.5),
                ),
              ),
              // Show last scanned table if any
              if (state.scannedTableId != null)
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: AppGlassContainer(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                        SizedBox(width: 12.w),
                        Text(
                          'Last synced: Table #${state.scannedTableId}',
                          style: AppTypography.labelMedium(context)
                              .copyWith(color: AppColors.success),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircularAction(Icons.flash_on),
                    SizedBox(width: 32.w),
                    _buildCircularAction(Icons.history),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Simulates a QR scan — in production this would use a camera + QR library.
  /// Here we cycle through tables 1-6 to mimic finding the next occupied one.
  void _simulateScan(BuildContext context) {
    // Cycle through tables to simulate finding the next active session
    final bloc = context.read<BaristaBloc>();
    // Find first table that is not vacant to "scan" it
    final state = bloc.state;
    int targetTable = 1;
    for (var table in state.tables) {
      if (table.status != TableStatus.vacant) {
        targetTable = table.tableId;
        break;
      }
    }
    bloc.add(SyncQRCodeEvent(targetTable));
  }
}

Widget _buildCircularAction(IconData icon) {
  return AppGlassContainer(
    width: 64.w,
    height: 64.w,
    borderRadius: 32.r,
    shape: BoxShape.circle,
    padding: EdgeInsets.zero,
    child: Center(child: Icon(icon, color: AppColors.primary, size: 24.sp)),
  );
}
