import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../ordering/bloc/ordering_bloc.dart';
import '../../ordering/bloc/ordering_state.dart';
import '../../ordering/models/product_model.dart';
import '../../ordering/bloc/ordering_event.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Curated List', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          final favorites = state.products.where((p) => p.isFavorite).toList();

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64.sp, color: AppColors.outline.withValues(alpha: 0.3)),
                  SizedBox(height: 24.h),
                  Text('Your curated list is empty.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(20.w),
            itemCount: favorites.length,
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemBuilder: (context, index) {
              return _buildWishlistItem(context, favorites[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildWishlistItem(BuildContext context, Product product) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                Text(product.category, style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => context.read<OrderingBloc>().add(ToggleFavoriteEvent(product.id)),
              ),
              GestureDetector(
                onTap: () {
                   context.read<OrderingBloc>().add(AddToCartEvent(product));
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${product.name} to cart')),
                  );
                },
                child: AppGlassContainer(
                  width: 44.w,
                  height: 44.w,
                  borderRadius: 12.r,
                  padding: EdgeInsets.zero,
                  child: Center(child: Icon(Icons.add_shopping_cart, color: AppColors.primary, size: 20.sp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
