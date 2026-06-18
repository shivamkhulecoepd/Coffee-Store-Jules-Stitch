import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AppAnimations {
  static const Duration defaultDuration = Duration(milliseconds: 300);

  static Widget fadeThroughTransition(Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }

  static PageRouteBuilder<T> fadePageRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
