import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  final Map<String, dynamic>? roleData;

  const LoginPage({super.key, this.roleData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final String role = state.role ?? roleData?['role'] ?? 'Customer';
        String targetRoute = 'home';
        if (role == 'Barista') targetRoute = 'barista';
        if (role == 'Administrator') targetRoute = 'admin';

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              TextButton(
                onPressed: () => context.goNamed(targetRoute),
                child: Text('SKIP', style: AppTypography.labelSmall(context)),
              ),
              SizedBox(width: 12.w),
            ],
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                context.goNamed(targetRoute);
              } else if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? 'Authentication Failed')),
                );
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text('Welcome Back,\n$role', style: AppTypography.displayLargeMobile(context)),
                  SizedBox(height: 12.h),
                  Text('Sign in to access your dashboard.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textSecondary)),
                  SizedBox(height: 48.h),
                  const AppTextField(
                    label: 'Email Address',
                    hint: 'name@example.com',
                    prefixIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 24.h),
                  const AppTextField(
                    label: 'Secure Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.pushNamed('forgot-password'),
                      child: Text('Forgot Password?', style: AppTypography.labelSmall(context).copyWith(fontSize: 11.sp)),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.status == AuthStatus.loading) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                      }
                      return AppButton(
                        text: 'AUTHENTICATE',
                        onPressed: () {
                          context.read<AuthBloc>().add(const LoginEvent('test@example.com', 'password'));
                        },
                      );
                    },
                  ),
                  SizedBox(height: 48.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: AppTypography.bodySmall(context)),
                      TextButton(
                        onPressed: () => context.pushNamed('register'),
                        child: Text('REGISTER', style: AppTypography.labelSmall(context).copyWith(fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
