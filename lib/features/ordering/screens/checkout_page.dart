import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/ordering_bloc.dart';
import '../bloc/ordering_event.dart';
import '../bloc/ordering_state.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Checkout', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, 'DELIVERY ADDRESS'),
                SizedBox(height: 16.h),
                AppGlassContainer(
                  padding: EdgeInsets.all(24.w),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.primary, size: 28.sp),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Office Studio', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                            Text('456 Barista Ave, Coffee District, 90210', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      Icon(Icons.edit_outlined, color: AppColors.primary, size: 20.sp),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                _buildSectionHeader(context, 'PAYMENT METHOD'),
                SizedBox(height: 16.h),
                AppGlassContainer(
                  padding: EdgeInsets.all(24.w),
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, color: AppColors.primary, size: 28.sp),
                      SizedBox(width: 20.w),
                      Text('•••• •••• •••• 4242', style: AppTypography.dataMono(context)),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right, color: AppColors.outline),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                _buildSectionHeader(context, 'ORDER SUMMARY'),
                SizedBox(height: 16.h),
                AppGlassContainer(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      ...state.cart.map((item) => _buildPriceRow(context, '${item.quantity}x ${item.product.name}', r'$' + (item.product.price * item.quantity).toStringAsFixed(2))),
                      _buildPriceRow(context, 'Express Delivery', r'$' + state.serviceFee.toStringAsFixed(2)),
                      const Divider(color: Colors.white10, height: 24),
                      _buildPriceRow(context, 'Total', r'$' + state.total.toStringAsFixed(2), isBold: true),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),
                state.isPlacingOrder
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : AppButton(
                      text: 'Place Secure Order',
                      onPressed: () {
                        context.read<OrderingBloc>().add(PlaceOrderEvent());
                        context.pushNamed('transmitted');
                      },
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(title, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2));
  }

  Widget _buildPriceRow(BuildContext context, String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: isBold ? AppTypography.labelMedium(context) : AppTypography.bodyMedium(context).copyWith(color: AppColors.outline), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Text(value, style: isBold ? AppTypography.headlineLarge(context).copyWith(color: AppColors.primary) : AppTypography.dataMono(context)),
        ],
      ),
    );
  }
}
