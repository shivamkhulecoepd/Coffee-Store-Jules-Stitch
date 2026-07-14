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
import '../models/user_model.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.customer;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(state.landingRoute);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Registration failed.'),
              backgroundColor: AppColors.error.withValues(alpha: 0.9),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('JOIN THE CLUB', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
                SizedBox(height: 8.h),
                Text('Create Account', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
                Text('Start your journey with premium coffee', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 48.h),
                AppTextField(
                  label: 'Full Name',
                  hint: 'Alex Johnson',
                  controller: _nameController,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: 'Email Address',
                  hint: 'alex@example.com',
                  controller: _emailController,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: 'Password',
                  hint: '••••••••',
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 24.h),
                Text('I am a:', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, letterSpacing: 2)),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  children: UserRole.values.map((role) {
                    final isSelected = _selectedRole == role;
                    return ChoiceChip(
                      label: Text(role.displayName),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedRole = role),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.onPrimary : Colors.white,
                        fontSize: 12.sp,
                      ),
                      backgroundColor: Colors.white10,
                    );
                  }).toList(),
                ),
                SizedBox(height: 48.h),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  AppButton(
                    text: 'CREATE ACCOUNT',
                    onPressed: () {
                      context.read<AuthBloc>().add(RegisterEvent(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        role: _selectedRole,
                      ));
                    },
                  ),
                SizedBox(height: 32.h),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: AppTypography.labelMedium(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
