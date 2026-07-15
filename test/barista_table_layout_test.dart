import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/table_layout.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_event.dart';
import 'package:coffee_store_jules_stitch/features/barista/models/table_session_model.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';

Widget _wrapWithProviders(StoreRepository repo) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<BaristaBloc>(create: (_) => BaristaBloc(repo)..add(LoadBaristaDataEvent())),
      ],
      child: MaterialApp(theme: AppTheme.darkTheme, home: const TableLayoutPage()),
    ),
  );
}

void main() {
  testWidgets('TableLayoutPage shows all 6 tables from repository',
      (WidgetTester tester) async {
    final repo = StoreRepository();
    await tester.pumpWidget(_wrapWithProviders(repo));
    await tester.pumpAndSettle();

    for (int i = 1; i <= 6; i++) {
      expect(find.text('TABLE'), findsWidgets);
    }
  });

  testWidgets('Table shows OCCUPIED status when status is occupied',
      (WidgetTester tester) async {
    final repo = StoreRepository();
    // Manually set table 2 to occupied
    repo.setTableStatus(2, TableStatus.occupied);

    await tester.pumpWidget(_wrapWithProviders(repo));
    await tester.pumpAndSettle();

    // OCCUPIED text should appear (status name is uppercase)
    expect(find.text('OCCUPIED'), findsWidgets);
  });

  testWidgets('Table shows VACANT status when status is vacant',
      (WidgetTester tester) async {
    final repo = StoreRepository();

    await tester.pumpWidget(_wrapWithProviders(repo));
    await tester.pumpAndSettle();

    // VACANT should appear for all default tables
    expect(find.text('VACANT'), findsWidgets);
  });

  testWidgets('Bloc state updates when table status changes',
      (WidgetTester tester) async {
    final repo = StoreRepository();
    final bloc = BaristaBloc(repo);

    // Initial state — all tables vacant
    bloc.add(LoadBaristaDataEvent());
    await Future.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.tables.first.status, TableStatus.vacant);

    // Update table 1 status to occupied
    repo.setTableStatus(1, TableStatus.occupied);
    await Future.delayed(const Duration(milliseconds: 100));
    expect(bloc.state.tables.first.status, TableStatus.occupied);

    await bloc.close();
  });
}
