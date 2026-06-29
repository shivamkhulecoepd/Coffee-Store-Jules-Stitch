import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/ordering_bloc.dart';
import '../bloc/ordering_event.dart';
import '../bloc/ordering_state.dart';
import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'ALL';

  @override
  void initState() {
    super.initState();
    context.read<OrderingBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(24.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('GOOD MORNING', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                            Text('Alex Johnson', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => context.pushNamed('notifications'),
                          child: AppGlassContainer(
                            width: 48.w,
                            height: 48.w,
                            borderRadius: 14.r,
                            padding: EdgeInsets.zero,
                            child: Center(child: Icon(Icons.notifications_none, color: Colors.white, size: 24.sp)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    _buildPromoCard(context),
                    SizedBox(height: 40.h),
                    _buildCategorySelector(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            BlocBuilder<OrderingBloc, OrderingState>(
              builder: (context, state) {
                if (state.status == OrderingStatus.loading) {
                  return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(color: AppColors.primary)));
                }

                final products = selectedCategory == 'ALL'
                  ? state.products
                  : state.products.where((p) => p.category == selectedCategory).toList();

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.h,
                      crossAxisSpacing: 20.w,
                      childAspectRatio: 0.68,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildProductCard(context, products[index]),
                      childCount: products.length,
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCard(BuildContext context) {
    return AppGlassContainer(
      height: 180.h,
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.auto_awesome, size: 200.sp, color: AppColors.primary),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4.r)),
                  child: Text('NEW ARRIVAL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.onPrimary, fontSize: 10.sp, fontWeight: FontWeight.w800)),
                ),
                SizedBox(height: 12.h),
                Text('Nitro Cold Brew', style: AppTypography.headlineLarge(context)),
                Text('Experience the velvety cascade.', style: AppTypography.bodySmall(context).copyWith(color: Colors.white70)),
                SizedBox(height: 16.h),
                Text('VIEW DETAILS', style: AppTypography.labelSmall(context).copyWith(fontSize: 10.sp, decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['ALL', 'ESPRESSO', 'BEANS', 'COLD', 'TEA', 'PASTRY'];
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20.r),
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index],
                style: AppTypography.labelSmall(context).copyWith(
                  color: isSelected ? AppColors.onPrimary : AppColors.outline,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => context.pushNamed('details', extra: {'tag': product.heroTag, 'product': product}),
      child: AppGlassContainer(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: product.heroTag,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.w,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: () => context.read<OrderingBloc>().add(ToggleFavoriteEvent(product.id)),
                      child: AppGlassContainer(
                        width: 32.w,
                        height: 32.w,
                        borderRadius: 10.r,
                        padding: EdgeInsets.zero,
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16.sp,
                          color: product.isFavorite ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(product.category, style: AppTypography.labelSmall(context).copyWith(fontSize: 10.sp, color: AppColors.outline)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () {
                    context.read<OrderingBloc>().add(AddToCartEvent(product));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${product.name} to selection')));
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8.r)),
                    child: Icon(Icons.add, size: 16.sp, color: AppColors.onPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
