import 'dart:async';
import '../models/user_model.dart';

/// Mock implementation of an authentication repository.
/// In production, replace the _mock* methods with real HTTP calls via ApiService.
class AuthRepository {
  String? _token;
  User? _currentUser;

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _currentUser != null;

  /// Stream that emits the current user whenever auth state changes.
  final StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  Stream<User?> get authStateStream => _authStateController.stream;

  AuthRepository() {
    _authStateController.add(null);
  }

  /// Register a new user with the given role.
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      role: role,
      loyaltyPoints: 100,
      loyaltyTier: 'Bronze',
      createdAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Authenticate with email and password. Returns User on success.
  Future<User> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Demo: any credentials succeed, role is derived from email for testing
    UserRole role = UserRole.customer;
    if (email.toLowerCase().contains('barista')) {
      role = UserRole.barista;
    } else if (email.toLowerCase().contains('admin')) {
      role = UserRole.administrator;
    }

    _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@').first.replaceAll('.', ' ').split(' ').map((s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '').join(' '),
      email: email,
      role: role,
      loyaltyPoints: 2450,
      loyaltyTier: 'Elite',
      createdAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  /// Send a one-time password to the given email.
  Future<void> sendOtp({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In production, call POST /auth/otp/send
  }

  /// Verify the OTP code and return whether it is valid.
  Future<bool> verifyOtp({required String email, required String otp}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Accept any 4-digit code for demo purposes
    return otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp);
  }

  /// Reset the user's password after OTP verification.
  Future<void> resetPassword({required String email, required String newPassword}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In production, call POST /auth/reset-password
  }

  /// Log the current user out and clear session.
  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _authStateController.add(null);
  }

  void dispose() {
    _authStateController.close();
  }
}
