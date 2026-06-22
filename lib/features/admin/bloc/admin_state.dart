import 'package:equatable/equatable.dart';

enum AdminStatus { initial, loading, loaded, error }

class AdminState extends Equatable {
  final AdminStatus status;
  final double dailyRevenue;
  final double avgBasket;
  final List<Map<String, dynamic>> requests;
  final List<Map<String, dynamic>> alerts;

  const AdminState({
    this.status = AdminStatus.initial,
    this.dailyRevenue = 0.0,
    this.avgBasket = 0.0,
    this.requests = const [],
    this.alerts = const [],
  });

  AdminState copyWith({
    AdminStatus? status,
    double? dailyRevenue,
    double? avgBasket,
    List<Map<String, dynamic>>? requests,
    List<Map<String, dynamic>>? alerts,
  }) {
    return AdminState(
      status: status ?? this.status,
      dailyRevenue: dailyRevenue ?? this.dailyRevenue,
      avgBasket: avgBasket ?? this.avgBasket,
      requests: requests ?? this.requests,
      alerts: alerts ?? this.alerts,
    );
  }

  @override
  List<Object> get props => [status, dailyRevenue, avgBasket, requests, alerts];
}
