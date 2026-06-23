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

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Discover', style: AppTypography.headlineMedium(context)),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<OrderingBloc, OrderingState>(
          builder: (context, state) {
            final roasts = state.products.where((p) => p.category == 'BEANS').toList();

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(24.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGlassContainer(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 64.h,
                          borderRadius: 16.r,
                          child: Row(
                            children: [
                              Icon(Icons.search, color: AppColors.primary, size: 24.sp),
                              SizedBox(width: 16.w),
                              Text('Search collections...',
                                style: AppTypography.bodyMedium(context).copyWith(
                                  color: AppColors.outline.withValues(alpha: 0.5)
                                )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                        _buildSectionHeader(context, 'Brewing Methods'),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: _buildBrewingMethodSliverGrid(context),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 24.w),
                  sliver: SliverToBoxAdapter(
                    child: _buildSectionHeader(context, 'Monthly Roasts'),
                  ),
                ),
                if (state.status == OrderingStatus.loading)
                  const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(color: AppColors.primary)))
                else
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _buildArrivalItem(context, roasts[index]),
                        ),
                        childCount: roasts.length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.headlineMedium(context)),
        Text('BROWSE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildBrewingMethodSliverGrid(BuildContext context) {
    final methods = [
      {'name': 'Pour Over', 'icon': Icons.water_drop_outlined},
      {'name': 'French Press', 'icon': Icons.coffee_maker_outlined},
      {'name': 'Cold Drip', 'icon': Icons.ac_unit_outlined},
      {'name': 'AeroPress', 'icon': Icons.compress_outlined},
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(methods[index]['icon'] as IconData, color: AppColors.primary, size: 28.sp),
                SizedBox(height: 12.h),
                Text(methods[index]['name'] as String, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          );
        },
        childCount: methods.length,
      ),
    );
  }

  Widget _buildArrivalItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => context.pushNamed('details', extra: {'tag': product.heroTag, 'product': product}),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        height: 110.h,
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text(product.description, style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Row(
              children: [
                Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => context.read<OrderingBloc>().add(ToggleFavoriteEvent(product.id)),
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 20.sp,
                    color: product.isFavorite ? Colors.red : AppColors.outline,
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
