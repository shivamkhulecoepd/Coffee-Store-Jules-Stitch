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

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 24.h),
                  Text('Transmitting your order...', style: AppTypography.bodyMedium(context)),
                ],
              ),
            );
          }

          if (state.cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64.sp, color: AppColors.outline),
                  SizedBox(height: 16.h),
                  Text('Your tray is empty.', style: AppTypography.bodyMedium(context)),
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

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
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
                _buildSectionHeader(context, 'Promo Code'),
                SizedBox(height: 16.h),
                _buildPromoSection(context, state),
                SizedBox(height: 32.h),
                _buildSectionHeader(context, 'Sequence Summary'),
                SizedBox(height: 16.h),
                _buildOrderSummary(context, state),
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
    return Text(
      title,
      style: AppTypography.labelSmall(context).copyWith(
        color: AppColors.primary,
        letterSpacing: 1.5,
      ),
    );
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

  Widget _buildPromoSection(BuildContext context, OrderingState state) {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  style: AppTypography.bodyMedium(context),
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    hintStyle: TextStyle(color: AppColors.outline.withValues(alpha: 0.5)),
                    prefixIcon: Icon(Icons.local_offer, color: AppColors.primary, size: 18.sp),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              if (state.appliedPromo != null)
                GestureDetector(
                  onTap: () {
                    _promoController.clear();
                    context.read<OrderingBloc>().add(RemovePromoCodeEvent());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text('REMOVE', style: TextStyle(color: AppColors.success, fontSize: 10.sp, fontWeight: FontWeight.w800)),
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    if (_promoController.text.isNotEmpty) {
                      context.read<OrderingBloc>().add(ApplyPromoCodeEvent(_promoController.text.trim()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text('APPLY', style: TextStyle(color: AppColors.onPrimary, fontSize: 10.sp, fontWeight: FontWeight.w800)),
                  ),
                ),
            ],
          ),
          if (state.appliedPromo != null) ...[
            SizedBox(height: 8.h),
            Text(
              '${state.appliedPromo!.description} — ${(state.appliedPromo!.discountPercent * 100).toStringAsFixed(0)}% off',
              style: TextStyle(color: AppColors.success, fontSize: 11.sp),
            ),
          ],
          if (state.promoError != null) ...[
            SizedBox(height: 8.h),
            Text(state.promoError!, style: TextStyle(color: AppColors.error, fontSize: 11.sp)),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, OrderingState state) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          ...state.cart.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.product.name}',
                        style: AppTypography.bodyMedium(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                      style: AppTypography.dataMono(context),
                    ),
                  ],
                ),
              )),
          const Divider(color: Colors.white10),
          _buildLineItem(context, 'Subtotal', '\$${state.subtotal.toStringAsFixed(2)}'),
          if (state.discount > 0)
            _buildLineItem(context, 'Discount', '-\$${state.discount.toStringAsFixed(2)}', isDiscount: true),
          _buildLineItem(context, 'Service Fee', '\$${state.serviceFee.toStringAsFixed(2)}'),
          const Divider(height: 24, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
              Text(
                '\$${state.total.toStringAsFixed(2)}',
                style: AppTypography.headlineMedium(context).copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLineItem(BuildContext context, String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodyMedium(context).copyWith(
              color: isDiscount ? AppColors.success : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.dataMono(context).copyWith(
              color: isDiscount ? AppColors.success : null,
            ),
          ),
        ],
      ),
    );
  }
}
