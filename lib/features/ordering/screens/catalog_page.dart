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

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String searchQuery = '';
  String selectedCategory = 'ALL';
  String sortBy = 'Name';

  @override
  void initState() {
    super.initState();
    context.read<OrderingBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Catalog', style: AppTypography.headlineMedium(context)),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          if (state.status == OrderingStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          final categories = ['ALL', ...state.products.map((p) => p.category).toSet()];

          var filteredProducts = state.products.where((p) {
            final matchesQuery = p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                                 p.description.toLowerCase().contains(searchQuery.toLowerCase());
            final matchesCategory = selectedCategory == 'ALL' || p.category == selectedCategory;
            return matchesQuery && matchesCategory;
          }).toList();

          if (sortBy == 'Price: Low to High') {
            filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          } else if (sortBy == 'Price: High to Low') {
            filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          } else if (sortBy == 'Rating') {
            filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
          } else {
            filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          }

          return Column(
            children: [
              _buildHeader(categories),
              Expanded(
                child: filteredProducts.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: EdgeInsets.all(24.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 20.w,
                        crossAxisSpacing: 20.w,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(filteredProducts[index]);
                      },
                    ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(List<String> categories) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          TextField(
            onChanged: (val) => setState(() => searchQuery = val),
            style: AppTypography.bodyMedium(context),
            decoration: InputDecoration(
              hintText: 'Search artisanal brews...',
              hintStyle: TextStyle(color: AppColors.outline.withValues(alpha: 0.5)),
              prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 20.sp),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) => setState(() => selectedCategory = cat),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.onPrimary : Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.white10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Sort by: ', style: AppTypography.bodySmall(context)),
              DropdownButton<String>(
                value: sortBy,
                dropdownColor: AppColors.surfaceDark,
                underline: const SizedBox(),
                items: ['Name', 'Price: Low to High', 'Price: High to Low', 'Rating']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(fontSize: 12.sp))))
                    .toList(),
                onChanged: (val) => setState(() => sortBy = val!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return AppGlassContainer(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: 'catalog_${product.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => context.read<OrderingBloc>().add(ToggleFavoriteEvent(product.id)),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                      child: Icon(
                        product.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(product.category, style: AppTypography.bodySmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
              GestureDetector(
                onTap: () {
                  context.read<OrderingBloc>().add(AddToCartEvent(product));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${product.name} to tray')));
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8.r)),
                  child: Icon(Icons.add, color: AppColors.onPrimary, size: 16.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64.sp, color: AppColors.outline.withValues(alpha: 0.3)),
          SizedBox(height: 16.h),
          Text('No products found matches your selection.', style: AppTypography.bodyMedium(context)),
        ],
      ),
    );
  }
}
