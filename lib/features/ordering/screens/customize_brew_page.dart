import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class CustomizeBrewPage extends StatefulWidget {
  const CustomizeBrewPage({super.key});

  @override
  State<CustomizeBrewPage> createState() => _CustomizeBrewPageState();
}

class _CustomizeBrewPageState extends State<CustomizeBrewPage> {
  String selectedSize = 'Medium';
  String selectedMilk = 'Oat Milk';
  double sweetness = 0.5;
  final List<String> toppings = [];

  void toggleTopping(String topping) {
    setState(() {
      if (toppings.contains(topping)) {
        toppings.remove(topping);
      } else {
        toppings.add(topping);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Customize Your Brew',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Size'),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectableChip('Small', selectedSize == 'Small', () => setState(() => selectedSize = 'Small')),
                _buildSelectableChip('Medium', selectedSize == 'Medium', () => setState(() => selectedSize = 'Medium')),
                _buildSelectableChip('Large', selectedSize == 'Large', () => setState(() => selectedSize = 'Large')),
              ],
            ),
            SizedBox(height: 32.h),
            _buildSectionTitle('Milk Choice'),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildSelectableChip('Whole Milk', selectedMilk == 'Whole Milk', () => setState(() => selectedMilk = 'Whole Milk')),
                _buildSelectableChip('Oat Milk', selectedMilk == 'Oat Milk', () => setState(() => selectedMilk = 'Oat Milk')),
                _buildSelectableChip('Almond Milk', selectedMilk == 'Almond Milk', () => setState(() => selectedMilk = 'Almond Milk')),
                _buildSelectableChip('Soy Milk', selectedMilk == 'Soy Milk', () => setState(() => selectedMilk = 'Soy Milk')),
              ],
            ),
            SizedBox(height: 32.h),
            _buildSectionTitle('Sweetness Level'),
            Slider(
              value: sweetness,
              activeColor: const Color(0xFFE2C4A9),
              inactiveColor: Colors.white10,
              onChanged: (val) => setState(() => sweetness = val),
            ),
            SizedBox(height: 32.h),
            _buildSectionTitle('Extra Toppings'),
            SizedBox(height: 12.h),
            AppGlassContainer(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _buildCheckboxRow('Extra Shot', toppings.contains('Extra Shot'), () => toggleTopping('Extra Shot')),
                  const Divider(color: Colors.white10),
                  _buildCheckboxRow('Caramel Drizzle', toppings.contains('Caramel Drizzle'), () => toggleTopping('Caramel Drizzle')),
                  const Divider(color: Colors.white10),
                  _buildCheckboxRow('Whipped Cream', toppings.contains('Whipped Cream'), () => toggleTopping('Whipped Cream')),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            AppButton(
              text: 'Add to Cart',
              onPressed: () {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart with customizations')),
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFFE2C4A9),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Manrope',
      ),
    );
  }

  Widget _buildSelectableChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE2C4A9) : Colors.white10,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF3F2D1A) : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(String label, bool isChecked, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: isChecked ? const Color(0xFFE2C4A9) : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
