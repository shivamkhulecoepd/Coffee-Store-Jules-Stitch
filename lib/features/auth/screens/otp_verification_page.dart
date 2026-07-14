import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final String _email = '';

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onOtpComplete(BuildContext context) {
    if (_otp.length == 4) {
      context.read<AuthBloc>().add(VerifyOtpEvent(email: _email, otp: _otp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpVerified) {
          context.pushNamed('reset-password');
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Invalid OTP.'),
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
                Text('SECURITY CHECK', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 8.h),
                Text('Verification', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
                Text('Enter the 4-digit code sent to your email.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 64.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) => _buildOTPField(context, index)),
                ),
                SizedBox(height: 64.h),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  AppButton(
                    text: 'VERIFY CODE',
                    onPressed: () => _onOtpComplete(context),
                  ),
                SizedBox(height: 32.h),
                Center(
                  child: Text(
                    'Resend code in 00:59',
                    style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOTPField(BuildContext context, int index) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.2)),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          }
          if (index == 3 && value.isNotEmpty) {
            _onOtpComplete(context);
          }
        },
      ),
    );
  }
}
