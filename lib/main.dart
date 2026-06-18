import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/welcome_page.dart';

void main() {
  runApp(const BeanAndBrewOS());
}

class BeanAndBrewOS extends StatelessWidget {
  const BeanAndBrewOS({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bean & Brew OS',
          theme: AppTheme.darkTheme,
          home: const WelcomePage(),
        );
      },
    );
  }
}
