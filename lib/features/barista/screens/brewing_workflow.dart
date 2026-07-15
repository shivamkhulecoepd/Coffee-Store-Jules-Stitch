import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/shot_timer.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';


class BrewingWorkflow extends StatefulWidget {
  /// Pass orderId via route extra: {'orderId': 'SESSION #400'}
  final Map<String, dynamic>? data;

  const BrewingWorkflow({super.key, this.data});

  @override
  State<BrewingWorkflow> createState() => _BrewingWorkflowState();
}

class _BrewingWorkflowState extends State<BrewingWorkflow> {
  /// Current brewing step (0-indexed). Steps advance automatically via timer.
  int _currentStep = 2; // Default to step 3 (0-based: 0=grind,1=tamp,2=extract,3=foam)
  Timer? _timer;
  String _elapsedSeconds = '24';
  bool _isComplete = false;

  String get _orderId => widget.data?['orderId'] ?? '';

  @override
  void initState() {
    super.initState();
    _startBrewingTimer();
  }

  void _startBrewingTimer() {
    int seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      seconds++;
      setState(() {
        _elapsedSeconds = seconds.toString();
        // Advance step at ~10s, ~20s, ~30s, ~40s
        if (seconds >= 40) {
          _currentStep = 3;
        } else if (seconds >= 30) {
          _currentStep = 2;
        } else if (seconds >= 20) {
          _currentStep = 1;
        } else {
          _currentStep = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _completeSequence() {
    _timer?.cancel();
    if (_orderId.isNotEmpty) {
                      context.read<BaristaBloc>().add(MarkBrewReadyEvent(_orderId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $_orderId marked as Ready!')),
    );
    }
    setState(() => _isComplete = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $_orderId marked as Ready!')),
    );
    context.pop();
  }

  double get _progress => (_currentStep + 1) / 4.0;

  static const _steps = [
    '1. Grinding Arabica Beans',
    '2. Precision Tamping',
    '3. Extraction Phase',
    '4. Micro-foam Texturing',
  ];

  @override
  Widget build(BuildContext context) {
    // Resolve real order title from repository if available
    final orderTitle = _orderId.isNotEmpty
        ? 'Brewing $_orderId'
        : 'Brewing Order';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(orderTitle, style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(32.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('EXTRACTION PROGRESS',
                      style: AppTypography.labelSmall(context)
                          .copyWith(color: AppColors.primary, letterSpacing: 2)),
                  SizedBox(height: 24.h),
                  ShotTimer(progress: _progress, time: _elapsedSeconds),
                  SizedBox(height: 24.h),
                  Text('Flow Rate: 1.2g/s',
                      style: AppTypography.dataMono(context)
                          .copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            SizedBox(height: 48.h),
            ...List.generate(_steps.length, (i) {
              final isDone = i < _currentStep || _isComplete;
              final isActive = i == _currentStep && !_isComplete;
              return _buildStep(context, _steps[i], isDone, isActive);
            }),
            SizedBox(height: 48.h),
            AppButton(
              text: _isComplete ? 'ALREADY COMPLETE' : 'Complete Sequence',
              onPressed: _isComplete ? () {} : _completeSequence,
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String label, bool isDone, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : (isActive ? Icons.radio_button_checked : Icons.radio_button_off),
            color: isDone
                ? AppColors.primary
                : (isActive ? AppColors.primaryGold : AppColors.outline.withValues(alpha: 0.3)),
            size: 24.sp,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              label,
              style: AppTypography.labelMedium(context).copyWith(
                color: isDone ? AppColors.boneWhite : AppColors.outline,
                decoration: isDone ? TextDecoration.lineThrough : null,
                fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
