import 'package:equatable/equatable.dart';

enum EmployeeStatus { onShift, offShift }

class Employee extends Equatable {
  final String name;
  final String role;
  final EmployeeStatus status;

  const Employee({
    required this.name,
    required this.role,
    this.status = EmployeeStatus.offShift,
  });

  Employee copyWith({
    String? name,
    String? role,
    EmployeeStatus? status,
  }) {
    return Employee(
      name: name ?? this.name,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, role, status];
}
