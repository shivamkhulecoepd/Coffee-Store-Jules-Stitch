import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routes/app_router.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  final Map<String, dynamic>? roleData;

  const LoginPage({super.key, this.roleData});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Route name (not path) for goNamed — matches AppRoute enum.
  String get _targetRouteName {
    final role = widget.roleData?['role'] as String? ?? 'Customer';
    if (role == 'Barista') return AppRoute.barista.name;
    if (role == 'Administrator') return AppRoute.admin.name;
    return AppRoute.home.name;
  }

  /// Full path for go() navigation.
  String get _targetPath {
    final role = widget.roleData?['role'] as String? ?? 'Customer';
    if (role == 'Barista') return '/barista';
    if (role == 'Administrator') return '/admin';
    return '/home';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.goNamed(_targetRouteName);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Authentication failed.'),
              backgroundColor: AppColors.error.withValues(alpha: 0.9),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              TextButton(
                onPressed: () => context.go(_targetPath),
                child: Text('SKIP', style: AppTypography.labelSmall(context)),
              ),
              SizedBox(width: 12.w),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Welcome Back,\n${widget.roleData?['role'] ?? 'Customer'}',
                  style: AppTypography.displayLargeMobile(context),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sign in to access your dashboard.',
                  style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(height: 48.h),
                AppTextField(
                  label: 'Email Address',
                  hint: 'name@example.com',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: 'Secure Password',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.pushNamed('forgot-password'),
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.labelSmall(context).copyWith(fontSize: 11.sp),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  AppButton(
                    text: 'AUTHENTICATE',
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginEvent(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      ));
                    },
                  ),
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: AppTypography.bodySmall(context)),
                    TextButton(
                      onPressed: () => context.pushNamed('register'),
                      child: Text(
                        'REGISTER',
                        style: AppTypography.labelSmall(context).copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
