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
import '../models/product_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Your Selection', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80.sp, color: AppColors.outline.withOpacity(0.3)),
                  SizedBox(height: 24.h),
                  Text('Your selection is empty.', style: AppTypography.bodyLarge(context).copyWith(color: AppColors.outline)),
                  SizedBox(height: 24.h),
                  AppButton(
                    text: 'BROWSE MENU',
                    width: 200.w,
                    onPressed: () => context.goNamed('home'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(24.w),
                  itemCount: state.cart.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemBuilder: (context, index) {
                    return _buildCartItem(context, state.cart[index]);
                  },
                ),
              ),
              _buildSummarySection(context, state),
              SizedBox(height: 100.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      height: 120.h,
      child: Row(
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.coffee, color: AppColors.primary, size: 40.sp),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(item.customization ?? 'Standard', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                SizedBox(height: 8.h),
                Text(r'$' + (item.product.price * item.quantity).toStringAsFixed(2), style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQtyBtn(context, Icons.add, () => context.read<OrderingBloc>().add(UpdateQuantityEvent(item.product.id, 1))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(item.quantity.toString(), style: AppTypography.dataMono(context)),
              ),
              _buildQtyBtn(context, Icons.remove, () => context.read<OrderingBloc>().add(UpdateQuantityEvent(item.product.id, -1))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Icon(icon, size: 14.sp, color: AppColors.primary),
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, OrderingState state) {
    return AppGlassContainer(
      borderRadius: 40.r,
      padding: EdgeInsets.all(32.w),
      boxShadow: AppTheme.premiumShadow,
      child: Column(
        children: [
          _buildSummaryRow(context, 'Subtotal', r'$' + state.subtotal.toStringAsFixed(2)),
          SizedBox(height: 12.h),
          _buildSummaryRow(context, 'Service Fee', r'$' + state.serviceFee.toStringAsFixed(2)),
          SizedBox(height: 16.h),
          const Divider(color: Colors.white10),
          SizedBox(height: 16.h),
          _buildSummaryRow(context, 'Total Amount', r'$' + state.total.toStringAsFixed(2), isTotal: true),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Proceed to Checkout',
            onPressed: () => context.pushNamed('checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTotal ? AppTypography.labelMedium(context).copyWith(color: AppColors.primary) : AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
        Text(value, style: isTotal ? AppTypography.headlineLarge(context) : AppTypography.dataMono(context)),
      ],
    );
  }
}
