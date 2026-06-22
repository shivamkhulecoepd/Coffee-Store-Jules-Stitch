import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
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
  String selectedCategory = 'ESPRESSO';

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
        child: BlocBuilder<OrderingBloc, OrderingState>(
          builder: (context, state) {
            if (state.status == OrderingStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            final filteredProducts = state.products.where((p) => p.category == selectedCategory).toList();

            return RefreshIndicator(
              onRefresh: () async => context.read<OrderingBloc>().add(LoadProductsEvent()),
              color: AppColors.primary,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 32.h),
                    _buildHeroSection(context),
                    SizedBox(height: 40.h),
                    Text('CATEGORIES', style: AppTypography.labelSmall(context).copyWith(letterSpacing: 2)),
                    SizedBox(height: 16.h),
                    _buildCategories(context),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('POPULAR BREWS', style: AppTypography.labelSmall(context).copyWith(letterSpacing: 2)),
                        Text('VIEW ALL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (filteredProducts.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(child: Text('No products found in this category.', style: AppTypography.bodySmall(context))),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24.h,
                          crossAxisSpacing: 24.w,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(context, filteredProducts[index]);
                        },
                      ),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LUXURY COFFEE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
            Text('Bean & Brew', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700)),
          ],
        ),
        AppGlassContainer(
          width: 56.w,
          height: 56.w,
          borderRadius: 28.r,
          padding: EdgeInsets.zero,
          child: Center(
            child: Icon(Icons.person_outline, color: AppColors.primary, size: 28.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return AppGlassContainer(
      height: 180.h,
      padding: EdgeInsets.all(24.w),
      boxShadow: AppTheme.premiumShadow,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('DAILY SPECIAL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                SizedBox(height: 8.h),
                Text('25% OFF', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 38.sp)),
                Text('Premium Roast Selections', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
              ],
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Icon(Icons.coffee, size: 80.sp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = ['ESPRESSO', 'COLD BREW', 'PASTRIES', 'BEANS'];
    return SizedBox(
      height: 48.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _buildCategoryChip(context, cat, selectedCategory == cat);
        },
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceDark.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => context.pushNamed('details', extra: {'tag': product.heroTag, 'product': product}),
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        boxShadow: AppTheme.premiumShadow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Hero(
                    tag: product.heroTag,
                    child: Icon(Icons.coffee, size: 48.sp, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(r'$' + product.price.toStringAsFixed(2), style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Icon(Icons.star, size: 14.sp, color: AppColors.primary),
                    SizedBox(width: 4.w),
                    Text(product.rating.toString(), style: AppTypography.dataMono(context).copyWith(fontSize: 12.sp, color: AppColors.outline)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
