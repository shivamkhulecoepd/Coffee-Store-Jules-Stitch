import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class PurchaseOrderPage extends StatefulWidget {
  const PurchaseOrderPage({super.key});

  @override
  State<PurchaseOrderPage> createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> {
  String? selectedSupplier;

  @override
  void initState() {
    super.initState();
    final repository = sl<StoreRepository>();
    selectedSupplier = repository.suppliers.first['name'];
  }

  @override
  Widget build(BuildContext context) {
    final repository = sl<StoreRepository>();
    final suppliers = repository.suppliers;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Procurement', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PRIMARY SUPPLIER', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 12.h),
            AppGlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 64.h,
              borderRadius: 16.r,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedSupplier,
                  dropdownColor: AppColors.surfaceLight,
                  icon: const Icon(Icons.unfold_more, color: AppColors.outline),
                  isExpanded: true,
                  items: suppliers.map((s) {
                    return DropdownMenuItem<String>(
                      value: s['name'],
                      child: Text(s['name'], style: AppTypography.labelMedium(context)),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedSupplier = val),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text('REQUISITION ITEMS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 16.h),
            _buildOrderItem(context, 'Arabica Light Roast', '10kg', r'0.00'),
            _buildOrderItem(context, 'Artisan Paper Cups (12oz)', '500 units', r'5.00'),
            SizedBox(height: 40.h),
            AppGlassContainer(
              borderRadius: 40.r,
              padding: EdgeInsets.all(32.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ESTIMATED REQUISITION', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline)),
                      Text(r'5.00', style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary)),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  AppButton(
                    text: 'AUTHORIZE TRANSMISSION',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order Transmitted to Supplier')),
                      );
                      context.pop();
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String name, String qty, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text('QUANTITY: $qty', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
                ],
              ),
            ),
            Text(price, style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
