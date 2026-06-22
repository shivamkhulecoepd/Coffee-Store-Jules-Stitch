import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import '../../../data/repositories/store_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final StoreRepository _repository;

  AdminBloc(this._repository) : super(const AdminState()) {
    on<LoadAdminDataEvent>(_onLoadData);
    on<ResolveRequestEvent>(_onResolveRequest);
  }

  void _onLoadData(LoadAdminDataEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(status: AdminStatus.loading));

    // Derived from repository orders in a real app
    final totalRevenue = _repository.orders.fold(0.0, (sum, o) => sum + (o['total'] as double));
    final avgBasket = _repository.orders.isEmpty ? 0.0 : totalRevenue / _repository.orders.length;

    emit(state.copyWith(
      status: AdminStatus.loaded,
      dailyRevenue: 1240.0 + totalRevenue, // Mock baseline + new orders
      avgBasket: 18.5 + avgBasket,
      requests: [
        {'id': '8820', 'desc': 'Inquiry regarding subscription renewal benefits.', 'status': 'PENDING'},
        {'id': '8821', 'desc': 'Request for table #4 group booking reservation.', 'status': 'PENDING'},
      ],
      alerts: [
        {'item': 'Arabica Espresso Reserves', 'status': 'LOW: 12kg', 'color': 'orange'},
        {'item': 'Whole Organic Dairy', 'status': 'CRITICAL: 5L', 'color': 'error'},
      ],
    ));
  }

  void _onResolveRequest(ResolveRequestEvent event, Emitter<AdminState> emit) {
    final updatedRequests = state.requests.map((r) {
      if (r['id'] == event.requestId) {
        return {...r, 'status': 'RESOLVED'};
      }
      return r;
    }).toList();
    emit(state.copyWith(requests: updatedRequests));
  }
}
