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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          context.pushNamed('otp');
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to send OTP.'),
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
          body: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RECOVER ACCOUNT', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 8.h),
                Text('Forgot Password', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                SizedBox(height: 16.h),
                Text('Enter your email to receive a secure recovery code.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 48.h),
                AppTextField(
                  label: 'Email Address',
                  hint: 'alex@example.com',
                  controller: _emailController,
                ),
                SizedBox(height: 48.h),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  AppButton(
                    text: 'SEND RESET CODE',
                    onPressed: () {
                      context.read<AuthBloc>().add(SendOtpEvent(_emailController.text.trim()));
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
