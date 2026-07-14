import 'package:equatable/equatable.dart';

/// User role enumeration used throughout the app for role-based access.
enum UserRole {
  customer('Customer'),
  barista('Barista'),
  administrator('Administrator');

  final String displayName;
  const UserRole(this.displayName);
}

/// Represents an authenticated user in the Bean & Brew OS system.
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? avatarUrl;
  final int loyaltyPoints;
  final String loyaltyTier;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
    this.loyaltyPoints = 0,
    this.loyaltyTier = 'Bronze',
    required this.createdAt,
  });

  /// Returns the route path this user should land on after login.
  String get landingRoute {
    switch (role) {
      case UserRole.customer:
        return '/home';
      case UserRole.barista:
        return '/barista';
      case UserRole.administrator:
        return '/admin';
    }
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? avatarUrl,
    int? loyaltyPoints,
    String? loyaltyTier,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      loyaltyTier: loyaltyTier ?? this.loyaltyTier,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, role, avatarUrl, loyaltyPoints, loyaltyTier, createdAt];
}
