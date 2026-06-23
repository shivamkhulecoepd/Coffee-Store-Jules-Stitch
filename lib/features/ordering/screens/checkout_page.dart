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
        title: Text('Finalize Sequence', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          if (state.isPlacingOrder) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, 'Delivery Destination'),
                SizedBox(height: 16.h),
                _buildAddressCard(context),
                SizedBox(height: 32.h),
                _buildSectionHeader(context, 'Payment Method'),
                SizedBox(height: 16.h),
                _buildPaymentCard(context),
                SizedBox(height: 32.h),
                _buildSectionHeader(context, 'Sequence Summary'),
                SizedBox(height: 16.h),
                AppGlassContainer(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      ...state.cart.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.quantity}x ${item.product.name}', style: AppTypography.bodyMedium(context)),
                            Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}', style: AppTypography.dataMono(context)),
                          ],
                        ),
                      )),
                      const Divider(color: Colors.white10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                          Text('\$${state.total.toStringAsFixed(2)}', style: AppTypography.headlineMedium(context).copyWith(color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),
                AppButton(
                  text: 'TRANSMIT ORDER',
                  onPressed: () {
                    context.read<OrderingBloc>().add(PlaceOrderEvent());
                    context.goNamed('transmitted');
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(title, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5));
  }

  Widget _buildAddressCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('address'),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Home Office', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text('421 Espresso Lane, Tech District', style: AppTypography.bodySmall(context)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('payment'),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(Icons.credit_card, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mastercard •••• 9021', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text('Exp: 12/26', style: AppTypography.bodySmall(context)),
                ],
              ),
            ),
            Icon(Icons.check_circle, color: AppColors.success, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
