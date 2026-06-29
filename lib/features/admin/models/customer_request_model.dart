import 'package:equatable/equatable.dart';

enum RequestStatus { pending, resolved }

class CustomerRequest extends Equatable {
  final String id;
  final String description;
  final RequestStatus status;

  const CustomerRequest({
    required this.id,
    required this.description,
    this.status = RequestStatus.pending,
  });

  CustomerRequest copyWith({
    String? id,
    String? description,
    RequestStatus? status,
  }) {
    return CustomerRequest(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [id, description, status];
}
