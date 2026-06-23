import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import '../features/admin/screens/admin_navigation_page.dart';
import '../features/admin/screens/inventory_status.dart';
import '../features/admin/screens/purchase_order.dart';
import '../features/admin/screens/supplier_directory.dart';
import '../features/admin/screens/customer_requests.dart';
import '../features/admin/screens/product_management.dart';
import '../features/admin/screens/employee_management.dart';
import '../features/admin/screens/system_settings.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', name: 'splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/welcome', name: 'welcome', builder: (context, state) => const WelcomePage()),
      GoRoute(path: '/role', name: 'role', builder: (context, state) => const ChooseRolePage()),
      GoRoute(path: '/login', name: 'login', builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return LoginPage(roleData: extra);
      }),
      GoRoute(path: '/register', name: 'register', builder: (context, state) => const RegistrationPage()),
      GoRoute(path: '/forgot-password', name: 'forgot-password', builder: (context, state) => const ForgotPasswordPage()),
      GoRoute(path: '/otp', name: 'otp', builder: (context, state) => const OTPVerificationPage()),
      GoRoute(path: '/reset-password', name: 'reset-password', builder: (context, state) => const ResetPasswordPage()),

      GoRoute(path: '/home', name: 'home', builder: (context, state) => const MainNavigationPage()),
      GoRoute(path: '/cart', name: 'cart', builder: (context, state) => const MainNavigationPage(initialIndex: 2)),
      GoRoute(path: '/details', name: 'details', builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ProductDetailsPage(data: extra);
      }),
      GoRoute(path: '/customize', name: 'customize', builder: (context, state) => const CustomizeBrewPage()),
      GoRoute(path: '/checkout', name: 'checkout', builder: (context, state) => const CheckoutPage()),
      GoRoute(path: '/transmitted', name: 'transmitted', builder: (context, state) => const OrderTransmittedPage()),
      GoRoute(path: '/confirmed', name: 'confirmed', builder: (context, state) => const OrderConfirmedPage()),
      GoRoute(path: '/tracking', name: 'tracking', builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return OrderTrackingPage(orderData: extra);
      }),

      GoRoute(path: '/history', name: 'history', builder: (context, state) => const OrderHistoryPage()),
      GoRoute(path: '/payment', name: 'payment', builder: (context, state) => const PaymentMethodsPage()),
      GoRoute(path: '/wishlist', name: 'wishlist', builder: (context, state) => const WishlistPage()),
      GoRoute(path: '/rewards', name: 'rewards', builder: (context, state) => const RewardsPage()),
      GoRoute(path: '/subscription', name: 'subscription', builder: (context, state) => const SubscriptionPage()),
      GoRoute(path: '/notifications', name: 'notifications', builder: (context, state) => const NotificationsPage()),
      GoRoute(path: '/address', name: 'address', builder: (context, state) => const AddressManagementPage()),
      GoRoute(path: '/settings', name: 'settings', builder: (context, state) => const SettingsPage()),
      GoRoute(path: '/points-history', name: 'points-history', builder: (context, state) => const PointsHistoryPage()),

      GoRoute(path: '/barista', name: 'barista', builder: (context, state) => const BaristaNavigationPage()),
      GoRoute(path: '/brewing', name: 'brewing', builder: (context, state) => const BrewingWorkflow()),
      GoRoute(path: '/ordering', name: 'ordering', builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return TableOrderingPage(data: extra);
      }),
      GoRoute(path: '/task-detail', name: 'task-detail', builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return TaskDetailPage(data: extra);
      }),
      GoRoute(path: '/overview', name: 'overview', builder: (context, state) => const ShiftOverviewPage()),
      GoRoute(path: '/handover', name: 'handover', builder: (context, state) => const ShiftHandoverPage()),
      GoRoute(path: '/billing', name: 'billing', builder: (context, state) => const ActiveTablesBillingPage()),
      GoRoute(path: '/scan', name: 'scan', builder: (context, state) => const ScanTableQRPage()),

      GoRoute(path: '/admin', name: 'admin', builder: (context, state) => const AdminNavigationPage()),
      GoRoute(path: '/inventory', name: 'inventory', builder: (context, state) => const InventoryStatusPage()),
      GoRoute(path: '/purchase', name: 'purchase', builder: (context, state) => const PurchaseOrderPage()),
      GoRoute(path: '/suppliers', name: 'suppliers', builder: (context, state) => const SupplierDirectoryPage()),
      GoRoute(path: '/requests', name: 'requests', builder: (context, state) => const CustomerRequestsPage()),
      GoRoute(path: '/product-mgmt', name: 'product-mgmt', builder: (context, state) => const ProductManagementPage()),
      GoRoute(path: '/employee-mgmt', name: 'employee-mgmt', builder: (context, state) => const EmployeeManagementPage()),
      GoRoute(path: '/admin-settings', name: 'admin-settings', builder: (context, state) => const SystemSettingsPage()),
    ],
  );
}
