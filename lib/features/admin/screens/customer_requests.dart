import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class CustomerRequestsPage extends StatelessWidget {
  const CustomerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Service Queue', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.requests.isEmpty) {
            return Center(child: Text('No pending requests.', style: AppTypography.bodySmall(context)));
          }

          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: state.requests.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final request = state.requests[index];
              final bool isResolved = request['status'] == 'RESOLVED';

              return AppGlassContainer(
                padding: EdgeInsets.all(20.w),
                opacity: isResolved ? 0.4 : 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TICKET #${request['id']}', style: AppTypography.dataMono(context).copyWith(fontSize: 10.sp)),
                        GestureDetector(
                          onTap: isResolved ? null : () => context.read<AdminBloc>().add(ResolveRequestEvent(request['id'])),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: (isResolved ? AppColors.success : AppColors.warning).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r)
                            ),
                            child: Text(
                              request['status'],
                              style: AppTypography.labelSmall(context).copyWith(
                                color: isResolved ? AppColors.success : AppColors.warning,
                                fontSize: 8.sp
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(request['desc'], style: AppTypography.bodyMedium(context)),
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
