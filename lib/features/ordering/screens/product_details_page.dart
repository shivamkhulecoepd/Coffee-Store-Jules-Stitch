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
    final Product? initialProduct = widget.data?['product'];
    final String heroTag = widget.data?['tag'] ?? 'default';

    if (initialProduct == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    return BlocBuilder<OrderingBloc, OrderingState>(
      builder: (context, state) {
        final product = state.products.firstWhere(
          (p) => p.id == initialProduct.id,
          orElse: () => initialProduct,
        );

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 500.h,
                child: Hero(
                  tag: heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.4),
                            AppColors.background,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCircleIcon(context, Icons.arrow_back_ios_new, onTap: () => context.pop()),
                            _buildCircleIcon(
                              context,
                              product.isFavorite ? Icons.favorite : Icons.favorite_border,
                              iconColor: product.isFavorite ? Colors.red : Colors.white,
                              onTap: () => context.read<OrderingBloc>().add(ToggleFavoriteEvent(product.id)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 250.h)),
                    SliverToBoxAdapter(
                      child: AppGlassContainer(
                        borderRadius: 40.r,
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text(product.name, style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary, fontSize: 28.sp)),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                                        SizedBox(width: 4.w),
                                        Text(product.rating.toString(), style: AppTypography.dataMono(context).copyWith(fontSize: 12.sp)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 32.h),
                            Text('THE BREW STORY', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                            SizedBox(height: 12.h),
                            Text(
                              product.description,
                              style: AppTypography.bodyMedium(context).copyWith(color: AppColors.boneWhite.withValues(alpha: 0.7), height: 1.7),
                            ),
                            SizedBox(height: 32.h),
                            _buildInfoGrid(context),
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
                            SizedBox(height: 120.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem(context, Icons.opacity, 'Medium', 'Body'),
        _buildInfoItem(context, Icons.thermostat, '92°C', 'Temp'),
        _buildInfoItem(context, Icons.timer, '4 min', 'Extraction'),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24.sp),
        SizedBox(height: 8.h),
        Text(value, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: AppTypography.bodySmall(context).copyWith(fontSize: 10.sp)),
      ],
    );
  }

  Widget _buildCircleIcon(BuildContext context, IconData icon, {VoidCallback? onTap, Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        width: 48.w,
        height: 48.w,
        borderRadius: 24.r,
        shape: BoxShape.circle,
        padding: EdgeInsets.zero,
        child: Center(child: Icon(icon, color: iconColor ?? Colors.white, size: 20.sp)),
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
          border: isSelected ? null : Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
