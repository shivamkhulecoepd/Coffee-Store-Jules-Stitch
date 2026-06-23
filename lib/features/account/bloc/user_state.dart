import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final String name;
  final String email;
  final int points;
  final String tier;
  final String subscriptionPlan;
  final bool isLoading;

  const UserState({
    this.name = 'Alex Johnson',
    this.email = 'alex.j@example.com',
    this.points = 2450,
    this.tier = 'Elite',
    this.subscriptionPlan = 'ELITE',
    this.isLoading = false,
  });

  UserState copyWith({
    String? name,
    String? email,
    int? points,
    String? tier,
    String? subscriptionPlan,
    bool? isLoading,
  }) {
    return UserState(
      name: name ?? this.name,
      email: email ?? this.email,
      points: points ?? this.points,
      tier: tier ?? this.tier,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [name, email, points, tier, subscriptionPlan, isLoading];
}
