import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_store_jules_stitch/features/barista/screens/table_detail_page.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_bloc.dart';
import 'package:coffee_store_jules_stitch/features/barista/bloc/barista_event.dart';
import 'package:coffee_store_jules_stitch/features/barista/models/table_session_model.dart';
import 'package:coffee_store_jules_stitch/data/repositories/store_repository.dart';
import 'package:coffee_store_jules_stitch/core/theme/app_theme.dart';
import 'package:coffee_store_jules_stitch/features/ordering/models/product_model.dart';

Widget _wrapWithProviders(StoreRepository repo, int tableId) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MultiBlocProvider(
      providers: [
        BlocProvider<BaristaBloc>(
          create: (_) => BaristaBloc(repo)..add(LoadBaristaDataEvent()),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: TableDetailPage(tableId: tableId),
      ),
    ),
  );
}

/// Helper to pump and settle with extra frames for async bloc operations
/// and event processing
Future<void> pumpWithSettle(WidgetTester tester, {int frames = 20}) async {
  // Pump multiple frames to allow bloc events to process
  for (int i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
}

void main() {
  // Use larger surface size for complex UI
  const testSurfaceSize = Size(1200, 1600);

  testWidgets('TableDetailPage shows correct table ID in title',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    // Create bloc with pre-loaded data to avoid timing issues
    final bloc = BaristaBloc(repo)..add(LoadBaristaDataEvent());
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => BlocProvider<BaristaBloc>.value(
          value: bloc,
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: TableDetailPage(tableId: 3),
          ),
        ),
      ),
    );
    await pumpWithSettle(tester);

    expect(find.text('Table #3 Detail'), findsOneWidget);
    
    await bloc.close();
  });

  testWidgets('TableDetailPage shows empty state when table has no items',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    final bloc = BaristaBloc(repo)..add(LoadBaristaDataEvent());
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => BlocProvider<BaristaBloc>.value(
          value: bloc,
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: TableDetailPage(tableId: 1),
          ),
        ),
      ),
    );
    await pumpWithSettle(tester);

    expect(find.text('No items in this session.'), findsOneWidget);
    
    await bloc.close();
  });

  testWidgets('TableDetailPage shows real items when session has items',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    // Add an item to table 1 session
    repo.addItemToTableSession(1, CartItem(
      product: const Product(
        id: '1',
        name: 'Signature Vanilla Latte',
        description: 'Test',
        price: 6.50,
        rating: 4.8,
        category: 'ESPRESSO',
        heroTag: 'latte',
        imageUrl: 'https://example.com/latte.jpg',
      ),
      quantity: 2,
      customization: 'Extra shot',
    ));

    final bloc = BaristaBloc(repo)..add(LoadBaristaDataEvent());
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => BlocProvider<BaristaBloc>.value(
          value: bloc,
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: TableDetailPage(tableId: 1),
          ),
        ),
      ),
    );
    await pumpWithSettle(tester);

    expect(find.text('Signature Vanilla Latte'), findsOneWidget);
    expect(find.text('Extra shot'), findsOneWidget);
    expect(find.text('x2'), findsOneWidget);
    
    await bloc.close();
  });

  testWidgets('TableDetailPage computes correct total from items',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    final price = 6.50;
    final qty = 2;
    repo.addItemToTableSession(1, CartItem(
      product: const Product(
        id: '1',
        name: 'Latte',
        description: 'Test',
        price: 6.50,
        rating: 4.8,
        category: 'ESPRESSO',
        heroTag: 'latte',
        imageUrl: 'https://example.com/latte.jpg',
      ),
      quantity: qty,
    ));

    final bloc = BaristaBloc(repo)..add(LoadBaristaDataEvent());
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => BlocProvider<BaristaBloc>.value(
          value: bloc,
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: TableDetailPage(tableId: 1),
          ),
        ),
      ),
    );
    await pumpWithSettle(tester);

    expect(find.text('\$${(price * qty).toStringAsFixed(2)}'), findsOneWidget);
    
    await bloc.close();
  });

  testWidgets('Close session button updates table status via bloc',
      (WidgetTester tester) async {
    tester.view.physicalSize = testSurfaceSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final repo = StoreRepository();
    repo.setTableStatus(5, TableStatus.occupied);

    final bloc = BaristaBloc(repo)..add(LoadBaristaDataEvent());
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) => BlocProvider<BaristaBloc>.value(
          value: bloc,
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: TableDetailPage(tableId: 5),
          ),
        ),
      ),
    );
    await pumpWithSettle(tester);

    // Find and tap Close Session button
    final closeButton = find.text('CLOSE SESSION');
    expect(closeButton, findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    // After close, session should be cleared
    expect(repo.findTableById(5)?.items, isEmpty);
    
    await bloc.close();
  });
}
