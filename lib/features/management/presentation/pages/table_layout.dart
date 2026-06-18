import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class TableLayoutPage extends StatelessWidget {
  const TableLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Floor Plan', style: AppTypography.headlineMedium),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          bool isOccupied = index % 3 == 0;
          return _buildTableItem(index + 1, isOccupied);
        },
      ),
    );
  }

  Widget _buildTableItem(int number, bool isOccupied) {
    return AppGlassContainer(
      borderRadius: 16.r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('T'+number.toString(), style: AppTypography.headlineMedium),
          SizedBox(height: 4.h),
          Text(
            isOccupied ? 'OCCUPIED' : 'VACANT',
            style: AppTypography.labelSmall.copyWith(
              color: isOccupied ? AppColors.primary : Colors.green,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
