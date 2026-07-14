import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';
import 'core/utils/service_locator.dart' as di;
import 'features/auth/bloc/auth_bloc.dart';
import 'features/ordering/bloc/ordering_bloc.dart';
import 'features/barista/bloc/barista_bloc.dart';
import 'features/admin/bloc/admin_bloc.dart';
import 'features/admin/bloc/inventory_bloc.dart';
import 'features/account/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const BeanAndBrewOS());
}

class BeanAndBrewOS extends StatelessWidget {
  const BeanAndBrewOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<OrderingBloc>()),
        BlocProvider(create: (_) => di.sl<BaristaBloc>()),
        BlocProvider(create: (_) => di.sl<AdminBloc>()),
        BlocProvider(create: (_) => di.sl<InventoryBloc>()),
        BlocProvider(create: (_) => di.sl<UserBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Bean & Brew OS',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
