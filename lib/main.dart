import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/navigation_provider.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/auth/presentation/pages/welcome_page.dart';
import 'features/auth/presentation/pages/choose_role_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/registration_page.dart';
import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/auth/presentation/pages/otp_verification_page.dart';
import 'features/auth/presentation/pages/reset_password_page.dart';
import 'features/customer/presentation/pages/main_navigation_page.dart';
import 'features/customer/presentation/pages/discover_page.dart';
import 'features/customer/presentation/pages/cart_page.dart';
import 'features/customer/presentation/pages/product_details_page.dart';
import 'features/customer/presentation/pages/checkout_page.dart';
import 'features/customer/presentation/pages/order_transmitted_page.dart';
import 'features/customer/presentation/pages/order_confirmed_page.dart';
import 'features/customer/presentation/pages/order_history_page.dart';
import 'features/customer/presentation/pages/payment_methods_page.dart';
import 'features/customer/presentation/pages/wishlist_page.dart';
import 'features/customer/presentation/pages/profile_page.dart';
import 'features/management/presentation/pages/barista_navigation_page.dart';
import 'features/management/presentation/pages/scan_table_qr.dart';
import 'features/management/presentation/pages/brewing_workflow.dart';
import 'features/management/presentation/pages/table_layout.dart';
import 'features/management/presentation/pages/table_ordering.dart';
import 'features/management/presentation/pages/operational_tasks.dart';
import 'features/management/presentation/pages/task_detail_page.dart';
import 'features/management/presentation/pages/barista_performance.dart';
import 'features/management/presentation/pages/shift_overview.dart';
import 'features/management/presentation/pages/shift_handover.dart';
import 'features/management/presentation/pages/active_tables_billing.dart';
import 'features/admin/presentation/pages/admin_navigation_page.dart';
import 'features/admin/presentation/pages/inventory_status.dart';
import 'features/admin/presentation/pages/purchase_order.dart';
import 'features/admin/presentation/pages/supplier_directory.dart';
import 'features/admin/presentation/pages/customer_requests.dart';
import 'features/rewards/presentation/pages/rewards_dashboard.dart';
import 'features/rewards/presentation/pages/points_history.dart';
import 'features/subscription/presentation/pages/subscription_plans.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const BeanAndBrewOS(),
    ),
  );
}

class BeanAndBrewOS extends StatelessWidget {
  const BeanAndBrewOS({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bean & Brew OS',
          theme: AppTheme.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/welcome': (context) => const WelcomePage(),
            '/role': (context) => const ChooseRolePage(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegistrationPage(),
            '/forgot-password': (context) => const ForgotPasswordPage(),
            '/otp': (context) => const OTPVerificationPage(),
            '/reset-password': (context) => const ResetPasswordPage(),
            '/home': (context) => const MainNavigationPage(),
            '/discover': (context) => const DiscoverPage(),
            '/cart': (context) => const CartPage(),
            '/details': (context) => const ProductDetailsPage(),
            '/checkout': (context) => const CheckoutPage(),
            '/transmitted': (context) => const OrderTransmittedPage(),
            '/confirmed': (context) => const OrderConfirmedPage(),
            '/history': (context) => const OrderHistoryPage(),
            '/payment': (context) => const PaymentMethodsPage(),
            '/wishlist': (context) => const WishlistPage(),
            '/profile': (context) => const ProfilePage(),
            '/barista': (context) => const BaristaNavigationPage(),
            '/brewing': (context) => const BrewingWorkflow(),
            '/tables': (context) => const TableLayoutPage(),
            '/ordering': (context) => const TableOrderingPage(),
            '/tasks': (context) => const OperationalTasksPage(),
            '/task-detail': (context) => const TaskDetailPage(),
            '/performance': (context) => const BaristaPerformancePage(),
            '/overview': (context) => const ShiftOverviewPage(),
            '/handover': (context) => const ShiftHandoverPage(),
            '/billing': (context) => const ActiveTablesBillingPage(),
            '/scan': (context) => const ScanTableQRPage(),
            '/admin': (context) => const AdminNavigationPage(),
            '/inventory': (context) => const InventoryStatusPage(),
            '/purchase': (context) => const PurchaseOrderPage(),
            '/suppliers': (context) => const SupplierDirectoryPage(),
            '/requests': (context) => const CustomerRequestsPage(),
            '/rewards': (context) => const RewardsDashboard(),
            '/points': (context) => const PointsHistoryPage(),
            '/subscription': (context) => const SubscriptionPlansPage(),
          },
        );
      },
    );
  }
}
