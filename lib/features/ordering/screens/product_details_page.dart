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
import '../models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const ProductDetailsPage({super.key, this.data});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    final Product? product = widget.data?['product'];
    final String heroTag = widget.data?['tag'] ?? 'default';

    if (product == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 480.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.espressoBold, AppColors.background],
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: 0.1,
                child: Hero(
                  tag: heroTag,
                  child: Icon(Icons.coffee, size: 280.sp, color: AppColors.primary),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircleIcon(context, Icons.arrow_back_ios_new, onTap: () => context.pop()),
                        _buildCircleIcon(context, Icons.favorite_border),
                      ],
                    ),
                  ),
                  SizedBox(height: 120.h),
                  AppGlassContainer(
                    borderRadius: 40.r,
                    padding: EdgeInsets.all(32.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SIGNATURE SERIES', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2.5)),
                                  SizedBox(height: 4.h),
                                  Text(product.name, style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                            Text(r'$' + product.price.toStringAsFixed(2), style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary, fontSize: 32.sp)),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        Text('DESCRIPTION', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                        SizedBox(height: 12.h),
                        Text(
                          product.description,
                          style: AppTypography.bodyMedium(context).copyWith(color: AppColors.boneWhite.withOpacity(0.65), height: 1.7),
                        ),
                        SizedBox(height: 40.h),
                        Text('CALIBRATE SIZE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            _buildSizeOption(context, 'S'),
                            _buildSizeOption(context, 'M'),
                            _buildSizeOption(context, 'L'),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        AppButton(
                          text: 'ADD TO SELECTION',
                          onPressed: () {
                            context.read<OrderingBloc>().add(AddToCartEvent(product, customization: 'Size: $selectedSize'));
                            context.pushNamed('cart');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(BuildContext context, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        width: 48.w,
        height: 48.w,
        borderRadius: 24.r,
        shape: BoxShape.circle,
        padding: EdgeInsets.zero,
        child: Center(child: Icon(icon, color: Colors.white, size: 20.sp)),
      ),
    );
  }

  Widget _buildSizeOption(BuildContext context, String size) {
    final bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        margin: EdgeInsets.only(right: 16.w),
        width: 68.w,
        height: 68.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(18.r),
          border: isSelected ? null : Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Center(
          child: Text(
            size,
            style: AppTypography.headlineMedium(context).copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
