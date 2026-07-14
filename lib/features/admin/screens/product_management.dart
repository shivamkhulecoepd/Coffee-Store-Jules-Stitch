import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../ordering/bloc/ordering_bloc.dart';
import '../../ordering/bloc/ordering_state.dart';

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Catalog Control', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.add, color: AppColors.primary), onPressed: () {}),
          SizedBox(width: 8.w),
        ],
      ),
      body: BlocBuilder<OrderingBloc, OrderingState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.all(20.w),
            itemCount: state.products.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return AppGlassContainer(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                          Text(product.category, style: AppTypography.labelSmall(context).copyWith(fontSize: 9.sp, color: AppColors.outline)),
                        ],
                      ),
                    ),
                    Text('\$${product.price.toStringAsFixed(2)}', style: AppTypography.dataMono(context)),
                    SizedBox(width: 16.w),
                    const Icon(Icons.edit_note, color: AppColors.primary),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
