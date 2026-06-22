import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';
import 'package:coffee_store_jules_stitch/core/utils/service_locator.dart' as di;
import 'package:coffee_store_jules_stitch/features/auth/bloc/auth_bloc.dart';
import 'package:coffee_store_jules_stitch/features/ordering/bloc/ordering_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/admin/bloc/admin_bloc.dart';
import 'package:coffee_store_jules_stitch/features/account/bloc/user_bloc.dart';

Widget wrapWithMaterial(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<OrderingBloc>()),
        BlocProvider(create: (_) => di.sl<BaristaBloc>()),
        BlocProvider(create: (_) => di.sl<AdminBloc>()),
        BlocProvider(create: (_) => di.sl<UserBloc>()),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: child,
      ),
    ),
  );
}
