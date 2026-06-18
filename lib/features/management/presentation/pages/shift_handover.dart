import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../shared/widgets/custom_button.dart';

class ShiftHandoverPage extends StatelessWidget {
  const ShiftHandoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Shift Handover', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            const AppTextField(
              label: 'Closing Cash Balance',
              hint: r'-bash.00',
            ),
            SizedBox(height: 24.h),
            const AppTextField(
              label: 'Incidents or Notes',
              hint: 'Describe any issues encountered...',
            ),
            SizedBox(height: 24.h),
            const AppTextField(
              label: 'Low Inventory Alert',
              hint: 'List items needing restock...',
            ),
            SizedBox(height: 48.h),
            AppButton(text: 'Submit Handover Report', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
