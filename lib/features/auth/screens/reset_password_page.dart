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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _email;

  bool get _passwordsMatch =>
      _passwordController.text == _confirmController.text &&
      _passwordController.text.isNotEmpty;

  void _submit() {
    context.read<AuthBloc>().add(ResetPasswordEvent(
          email: _email ?? '',
          newPassword: _passwordController.text,
        ));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset successful. Please login.'),
              backgroundColor: Colors.green,
            ),
          );
          context.goNamed('login');
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Password reset failed.'),
              backgroundColor: AppColors.error.withValues(alpha: 0.9),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CREATE NEW', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 8.h),
                Text('Secure Password', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                Text('Update your credentials for account safety.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 48.h),
                AppTextField(
                  label: 'New Password',
                  hint: '••••••••',
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: 'Confirm Password',
                  hint: '••••••••',
                  isPassword: true,
                  controller: _confirmController,
                ),
                if (_confirmController.text.isNotEmpty &&
                    _passwordController.text != _confirmController.text)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      'Passwords do not match.',
                      style: TextStyle(color: AppColors.error, fontSize: 12.sp),
                    ),
                  ),
                SizedBox(height: 48.h),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  AppButton(
                    text: 'UPDATE PASSWORD',
                    onPressed: _passwordsMatch ? _submit : () {},
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
