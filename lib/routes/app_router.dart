import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/welcome_page.dart';
import '../features/auth/screens/choose_role_page.dart';
import '../features/auth/screens/login_page.dart';
import '../features/auth/screens/registration_page.dart';
import '../features/auth/screens/forgot_password_page.dart';
import '../features/auth/screens/otp_verification_page.dart';
import '../features/auth/screens/reset_password_page.dart';
import '../features/ordering/screens/main_navigation_page.dart';
import '../features/ordering/screens/product_details_page.dart';
import '../features/ordering/screens/checkout_page.dart';
import '../features/ordering/screens/order_transmitted_page.dart';
import '../features/ordering/screens/order_confirmed_page.dart';
import '../features/ordering/screens/customize_brew_page.dart';
import '../features/ordering/screens/order_tracking_page.dart';
import '../features/account/screens/order_history_page.dart';
import '../features/account/screens/payment_methods_page.dart';
import '../features/account/screens/wishlist_page.dart';
import '../features/account/screens/rewards_page.dart';
import '../features/account/screens/subscription_page.dart';
import '../features/account/screens/notifications_page.dart';
import '../features/account/screens/address_management_page.dart';
import '../features/account/screens/settings_page.dart';
import '../features/account/screens/points_history_page.dart';
import '../features/barista/screens/barista_navigation_page.dart';
import '../features/barista/screens/brewing_workflow.dart';
import '../features/barista/screens/table_ordering.dart';
import '../features/barista/screens/task_detail_page.dart';
import '../features/barista/screens/shift_overview.dart';
import '../features/barista/screens/shift_handover.dart';
import '../features/barista/screens/active_tables_billing.dart';
import '../features/barista/screens/scan_table_qr.dart';
import '../features/barista/screens/table_detail_page.dart';
import '../features/admin/screens/admin_navigation_page.dart';
import '../features/admin/screens/inventory_status.dart';
import '../features/admin/screens/purchase_order.dart';
import '../features/admin/screens/supplier_directory.dart';
import '../features/admin/screens/customer_requests.dart';
import '../features/admin/screens/product_management.dart';
import '../features/admin/screens/employee_management.dart';
import '../features/admin/screens/system_settings.dart';

/// Route names as an enum for type-safe routing.
enum AppRoute {
  splash,
  welcome,
  role,
  login,
  register,
  forgotPassword,
  otp,
  resetPassword,
  home,
  cart,
  details,
  customize,
  checkout,
  transmitted,
  confirmed,
  tracking,
  history,
  payment,
  wishlist,
  rewards,
  subscription,
  notifications,
  address,
  settings,
  pointsHistory,
  barista,
  brewing,
  ordering,
  taskDetail,
  tableDetail,
  overview,
  handover,
  billing,
  scan,
  admin,
  inventory,
  purchase,
  suppliers,
  requests,
  productMgmt,
  employeeMgmt,
  adminSettings,
}

/// Maps enum values to route names.
extension AppRouteX on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.splash: return 'splash';
      case AppRoute.welcome: return 'welcome';
      case AppRoute.role: return 'role';
      case AppRoute.login: return 'login';
      case AppRoute.register: return 'register';
      case AppRoute.forgotPassword: return 'forgot-password';
      case AppRoute.otp: return 'otp';
      case AppRoute.resetPassword: return 'reset-password';
      case AppRoute.home: return 'home';
      case AppRoute.cart: return 'cart';
      case AppRoute.details: return 'details';
      case AppRoute.customize: return 'customize';
      case AppRoute.checkout: return 'checkout';
      case AppRoute.transmitted: return 'transmitted';
      case AppRoute.confirmed: return 'confirmed';
      case AppRoute.tracking: return 'tracking';
      case AppRoute.history: return 'history';
      case AppRoute.payment: return 'payment';
      case AppRoute.wishlist: return 'wishlist';
      case AppRoute.rewards: return 'rewards';
      case AppRoute.subscription: return 'subscription';
      case AppRoute.notifications: return 'notifications';
      case AppRoute.address: return 'address';
      case AppRoute.settings: return 'settings';
      case AppRoute.pointsHistory: return 'points-history';
      case AppRoute.barista: return 'barista';
      case AppRoute.brewing: return 'brewing';
      case AppRoute.ordering: return 'ordering';
      case AppRoute.taskDetail: return 'task-detail';
      case AppRoute.tableDetail: return 'table-detail';
      case AppRoute.overview: return 'overview';
      case AppRoute.handover: return 'handover';
      case AppRoute.billing: return 'billing';
      case AppRoute.scan: return 'scan';
      case AppRoute.admin: return 'admin';
      case AppRoute.inventory: return 'inventory';
      case AppRoute.purchase: return 'purchase';
      case AppRoute.suppliers: return 'suppliers';
      case AppRoute.requests: return 'requests';
      case AppRoute.productMgmt: return 'product-mgmt';
      case AppRoute.employeeMgmt: return 'employee-mgmt';
      case AppRoute.adminSettings: return 'admin-settings';
    }
  }
}

/// Routes that require authentication.
const _protectedCustomerRoutes = [
  AppRoute.home,
  AppRoute.cart,
  AppRoute.details,
  AppRoute.customize,
  AppRoute.checkout,
  AppRoute.transmitted,
  AppRoute.confirmed,
  AppRoute.tracking,
  AppRoute.history,
  AppRoute.payment,
  AppRoute.wishlist,
  AppRoute.rewards,
  AppRoute.subscription,
  AppRoute.notifications,
  AppRoute.address,
  AppRoute.settings,
  AppRoute.pointsHistory,
];

const _protectedBaristaRoutes = [
  AppRoute.barista,
  AppRoute.brewing,
  AppRoute.ordering,
  AppRoute.taskDetail,
  AppRoute.tableDetail,
  AppRoute.overview,
  AppRoute.handover,
  AppRoute.billing,
  AppRoute.scan,
];

const _protectedAdminRoutes = [
  AppRoute.admin,
  AppRoute.inventory,
  AppRoute.purchase,
  AppRoute.suppliers,
  AppRoute.requests,
  AppRoute.productMgmt,
  AppRoute.employeeMgmt,
  AppRoute.adminSettings,
];

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Guard all protected routes based on auth state
      final authState = BlocProvider.of<AuthBloc>(context, listen: false).state;
      final isAuthenticated = authState.isAuthenticated;
      final userRole = authState.user?.role;

      final path = state.matchedLocation;

      bool isProtectedRoute = _protectedCustomerRoutes.any((r) => path == '/${r.name}') ||
          _protectedBaristaRoutes.any((r) => path == '/${r.name}') ||
          _protectedAdminRoutes.any((r) => path == '/${r.name}');

      if (!isProtectedRoute) return null;

      // Not authenticated — redirect to welcome
      if (!isAuthenticated) {
        if (path != '/welcome') return '/welcome';
        return null;
      }

      // Authenticated — enforce role-based access
      final isCustomerRoute = _protectedCustomerRoutes.any((r) => path == '/${r.name}');
      final isBaristaRoute = _protectedBaristaRoutes.any((r) => path == '/${r.name}');
      final isAdminRoute = _protectedAdminRoutes.any((r) => path == '/${r.name}');

      if (isCustomerRoute && userRole != null && userRole.name != 'customer') {
        return authState.user?.landingRoute;
      }
      if (isBaristaRoute && userRole != null && userRole.name != 'barista') {
        return authState.user?.landingRoute;
      }
      if (isAdminRoute && userRole != null && userRole.name != 'administrator') {
        return authState.user?.landingRoute;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', name: AppRoute.splash.name, builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/welcome', name: AppRoute.welcome.name, builder: (context, state) => const WelcomePage()),
      GoRoute(path: '/role', name: AppRoute.role.name, builder: (context, state) => const ChooseRolePage()),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return LoginPage(roleData: extra);
        },
      ),
      GoRoute(path: '/register', name: AppRoute.register.name, builder: (context, state) => const RegistrationPage()),
      GoRoute(path: '/forgot-password', name: AppRoute.forgotPassword.name, builder: (context, state) => const ForgotPasswordPage()),
      GoRoute(path: '/otp', name: AppRoute.otp.name, builder: (context, state) => const OTPVerificationPage()),
      GoRoute(path: '/reset-password', name: AppRoute.resetPassword.name, builder: (context, state) => const ResetPasswordPage()),

      // Customer routes
      GoRoute(path: '/home', name: AppRoute.home.name, builder: (context, state) => const MainNavigationPage()),
      GoRoute(path: '/cart', name: AppRoute.cart.name, builder: (context, state) => const MainNavigationPage(initialIndex: 2)),
      GoRoute(
        path: '/details',
        name: AppRoute.details.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ProductDetailsPage(data: extra);
        },
      ),
      GoRoute(path: '/customize', name: AppRoute.customize.name, builder: (context, state) => const CustomizeBrewPage()),
      GoRoute(path: '/checkout', name: AppRoute.checkout.name, builder: (context, state) => const CheckoutPage()),
      GoRoute(path: '/transmitted', name: AppRoute.transmitted.name, builder: (context, state) => const OrderTransmittedPage()),
      GoRoute(path: '/confirmed', name: AppRoute.confirmed.name, builder: (context, state) => const OrderConfirmedPage()),
      GoRoute(
        path: '/tracking',
        name: AppRoute.tracking.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OrderTrackingPage(orderData: extra);
        },
      ),

      // Account routes
      GoRoute(path: '/history', name: AppRoute.history.name, builder: (context, state) => const OrderHistoryPage()),
      GoRoute(path: '/payment', name: AppRoute.payment.name, builder: (context, state) => const PaymentMethodsPage()),
      GoRoute(path: '/wishlist', name: AppRoute.wishlist.name, builder: (context, state) => const WishlistPage()),
      GoRoute(path: '/rewards', name: AppRoute.rewards.name, builder: (context, state) => const RewardsPage()),
      GoRoute(path: '/subscription', name: AppRoute.subscription.name, builder: (context, state) => const SubscriptionPage()),
      GoRoute(path: '/notifications', name: AppRoute.notifications.name, builder: (context, state) => const NotificationsPage()),
      GoRoute(path: '/address', name: AppRoute.address.name, builder: (context, state) => const AddressManagementPage()),
      GoRoute(path: '/settings', name: AppRoute.settings.name, builder: (context, state) => const SettingsPage()),
      GoRoute(path: '/points-history', name: AppRoute.pointsHistory.name, builder: (context, state) => const PointsHistoryPage()),

      // Barista routes
      GoRoute(path: '/barista', name: AppRoute.barista.name, builder: (context, state) => const BaristaNavigationPage()),
      GoRoute(path: '/brewing', name: AppRoute.brewing.name, builder: (context, state) => const BrewingWorkflow()),
      GoRoute(
        path: '/ordering',
        name: AppRoute.ordering.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return TableOrderingPage(data: extra);
        },
      ),
      GoRoute(
        path: '/task-detail',
        name: AppRoute.taskDetail.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return TaskDetailPage(data: extra);
        },
      ),
      GoRoute(
        path: '/table-detail',
        name: AppRoute.tableDetail.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final tableId = extra?['tableId'] as int? ?? 1;
          return TableDetailPage(tableId: tableId);
        },
      ),
      GoRoute(path: '/overview', name: AppRoute.overview.name, builder: (context, state) => const ShiftOverviewPage()),
      GoRoute(path: '/handover', name: AppRoute.handover.name, builder: (context, state) => const ShiftHandoverPage()),
      GoRoute(path: '/billing', name: AppRoute.billing.name, builder: (context, state) => const ActiveTablesBillingPage()),
      GoRoute(path: '/scan', name: AppRoute.scan.name, builder: (context, state) => const ScanTableQRPage()),

      // Admin routes
      GoRoute(path: '/admin', name: AppRoute.admin.name, builder: (context, state) => const AdminNavigationPage()),
      GoRoute(path: '/inventory', name: AppRoute.inventory.name, builder: (context, state) => const InventoryStatusPage()),
      GoRoute(path: '/purchase', name: AppRoute.purchase.name, builder: (context, state) => const PurchaseOrderPage()),
      GoRoute(path: '/suppliers', name: AppRoute.suppliers.name, builder: (context, state) => const SupplierDirectoryPage()),
      GoRoute(path: '/requests', name: AppRoute.requests.name, builder: (context, state) => const CustomerRequestsPage()),
      GoRoute(path: '/product-mgmt', name: AppRoute.productMgmt.name, builder: (context, state) => const ProductManagementPage()),
      GoRoute(path: '/employee-mgmt', name: AppRoute.employeeMgmt.name, builder: (context, state) => const EmployeeManagementPage()),
      GoRoute(path: '/admin-settings', name: AppRoute.adminSettings.name, builder: (context, state) => const SystemSettingsPage()),
    ],
  );
}
