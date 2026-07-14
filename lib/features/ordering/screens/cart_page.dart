import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
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
        title: Text('Selection', style: AppTypography.headlineMedium(context)),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80.sp, color: AppColors.outline.withValues(alpha: 0.2)),
                  SizedBox(height: 24.h),
                  Text('Your tray is empty.', style: AppTypography.bodyLarge(context).copyWith(color: AppColors.outline)),
                  SizedBox(height: 32.h),
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
                  padding: EdgeInsets.all(20.w),
                  itemCount: state.cart.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    return _buildCartItem(context, state.cart[index]);
                  },
                ),
              ),
              _buildSummary(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(item.product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                if (item.customization != null)
                  Text(item.customization!, style: AppTypography.bodySmall(context).copyWith(fontSize: 10.sp)),
                SizedBox(height: 8.h),
                Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Row(
            children: [
              _buildQtyBtn(context, Icons.remove, () => context.read<OrderingBloc>().add(UpdateQuantityEvent(item.product.id, -1))),
              SizedBox(width: 12.w),
              Text('${item.quantity}', style: AppTypography.labelMedium(context)),
              SizedBox(width: 12.w),
              _buildQtyBtn(context, Icons.add, () => context.read<OrderingBloc>().add(UpdateQuantityEvent(item.product.id, 1))),
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
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 14.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildSummary(BuildContext context, OrderingState state) {
    return SafeArea(
      child: AppGlassContainer(
        borderRadius: 0,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildSummaryRow(context, 'Subtotal', '\$${state.subtotal.toStringAsFixed(2)}'),
            SizedBox(height: 12.h),
            _buildSummaryRow(context, 'Service Fee', '\$${state.serviceFee.toStringAsFixed(2)}'),
            const Divider(height: 32, color: Colors.white10),
            _buildSummaryRow(context, 'Total', '\$${state.total.toStringAsFixed(2)}', isTotal: true),
            SizedBox(height: 20.h),
            AppButton(
              text: 'PROCEED TO CHECKOUT',
              onPressed: () => context.pushNamed('checkout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTotal ? AppTypography.labelMedium(context) : AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
        Text(value, style: isTotal ? AppTypography.headlineMedium(context).copyWith(color: AppColors.primary) : AppTypography.dataMono(context)),
      ],
    );
  }
}
