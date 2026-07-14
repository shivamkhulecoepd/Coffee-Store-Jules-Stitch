import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/custom_button.dart';

class ShiftHandoverPage extends StatelessWidget {
  const ShiftHandoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Sequence Handover', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            const AppTextField(
              label: 'CLOSING BALANCE',
              hint: r'-bash.00',
            ),
            SizedBox(height: 32.h),
            const AppTextField(
              label: 'INCIDENT LOGS',
              hint: 'Record any station irregularities...',
            ),
            SizedBox(height: 32.h),
            const AppTextField(
              label: 'INVENTORY SYNC',
              hint: 'List critical stock shortages...',
            ),
            SizedBox(height: 64.h),
            AppButton(text: 'TRANSMIT HANDOVER', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }
}
