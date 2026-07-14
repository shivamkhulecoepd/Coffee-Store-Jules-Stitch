# DOCS_ANALYSIS.md — Bean & Brew OS Gap Report

**Generated:** 2026-07-14
**Analyst:** Mavis (MiniMax Agent)
**Reference Docs:** `FUNCTIONALITIES.md`, `UI_UX_BRIEF.md`, `PRD.md`, `IMPLEMENTATION_PLAN.md`, `APP_FLOW.md`

---

## Conventions Used

| Tag | Meaning |
|-----|---------|
| ✅ ALREADY IMPLEMENTED | Feature exists with correct behavior |
| ⚠️ PARTIAL | Feature exists but is incomplete |
| ❌ MISSING | Referenced in docs but not present in code |
| 🔴 P0 | Blocking — core flows cannot function without this |
| 🟡 P1 | Important — degraded UX or broken sub-flows |
| 🟢 P2 | Nice-to-have — polish and completeness |

---

## 1. Authentication & Onboarding

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| Splash screen with animated brand intro | ✅ IMPLEMENTED | `features/auth/screens/splash_screen.dart` | — | |
| Welcome / Onboarding page | ✅ IMPLEMENTED | `features/auth/screens/welcome_page.dart` | — | |
| Role selection (Customer/Barista/Admin) | ✅ IMPLEMENTED | `features/auth/screens/choose_role_page.dart` | — | |
| Login screen | ✅ IMPLEMENTED | `features/auth/screens/login_page.dart` | — | |
| Registration screen | ⚠️ PARTIAL | `features/auth/screens/registration_page.dart` | — | Has UI but does NOT dispatch any `AuthEvent` — button just calls `context.goNamed('home')`. No `RegisterEvent` in `AuthEvent`. |
| Forgot password → OTP flow | ⚠️ PARTIAL | `features/auth/screens/forgot_password_page.dart`, `otp_verification_page.dart` | — | Pages exist; button on OTP page navigates to reset. But no `SendOtpEvent`, `VerifyOtpEvent`, `ResetPasswordEvent` in `AuthEvent`. |
| Reset password page | ✅ IMPLEMENTED | `features/auth/screens/reset_password_page.dart` | — | |
| `AuthBloc` with full state machine | ⚠️ PARTIAL | `features/auth/bloc/auth_bloc.dart` | — | Only has `SelectRoleEvent` and `LoginEvent`. Missing: `RegisterEvent`, `SendOtpEvent`, `VerifyOtpEvent`, `ResetPasswordEvent`, `LogoutEvent`. `AuthState` has no `User` object — only stores `role` as a String. |
| `AuthRepository` with login/register/sendOtp/verifyOtp/resetPassword/logout | ❌ MISSING | No `features/auth/repositories/auth_repository.dart` | 🔴 P0 | Required for testable auth flow with mocked API. |
| `User` model with role | ❌ MISSING | No `features/auth/models/user_model.dart` | 🔴 P0 | `AuthState` needs a proper `User` object instead of just a `String? role`. |
| `ApiService` integration in auth | ⚠️ PARTIAL | `services/api_service.dart` exists | — | `ApiService` exists but is not wired into `AuthBloc`. AuthBloc uses `Future.delayed` mock only. |
| Role-based navigation guards (route → landing page by role) | ❌ MISSING | `routes/app_router.dart` | 🔴 P0 | All routes are public. No `redirect` callbacks enforcing role. Customer goes to `/home`, Barista to `/barista`, Admin to `/admin`. |
| Secure token storage (`flutter_secure_storage`) | ❌ MISSING | No dependency | 🟡 P1 | Required for persisting auth tokens. |
| Auth BLoC unit tests | ❌ MISSING | No `test/features/auth/` | 🔴 P0 | |

---

## 2. Customer Module (Catalog, Ordering, Cart, Checkout, Tracking)

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| `CustomerHomeScreen` (dashboard with featured items, loyalty) | ✅ IMPLEMENTED | `features/ordering/screens/home_page.dart` | — | |
| `CatalogScreen` with search + filter + sort | ✅ IMPLEMENTED | `features/ordering/screens/catalog_page.dart` | — | Basic search (String.contains) implemented. No fuzzy search. |
| Fuzzy search | ❌ MISSING | `features/ordering/bloc/ordering_bloc.dart` | 🟡 P1 | Need in-memory fuzzy search index or use `fuzzy` package. |
| `ProductDetailScreen` | ✅ IMPLEMENTED | `features/ordering/screens/product_details_page.dart` | — | |
| `CustomizeBrewPage` | ⚠️ PARTIAL | `features/ordering/screens/customize_brew_page.dart` | — | UI complete but does NOT add item to cart with customization details. `AddToCartEvent` has a `customization` field but it's never populated from this screen. |
| Dynamic price update on customization | ❌ MISSING | `customize_brew_page.dart` | 🟡 P1 | No price recalculation based on selected extras (e.g., extra shot +$0.75). |
| `CartScreen` | ✅ IMPLEMENTED | `features/ordering/screens/cart_page.dart` | — | |
| `CheckoutScreen` | ⚠️ PARTIAL | `features/ordering/screens/checkout_page.dart` | — | Address/payment sections are UI-only (no actual selection). `PlaceOrderEvent` is fired but promo code is not supported. |
| Promo code / discount application | ❌ MISSING | `features/ordering/bloc/ordering_bloc.dart` | 🟡 P1 | `ApplyPromoCodeEvent`, promo validation, discount calculation. |
| Order confirmation | ✅ IMPLEMENTED | `features/ordering/screens/order_confirmed_page.dart` | — | |
| Order tracking screen | ✅ IMPLEMENTED | `features/ordering/screens/order_tracking_page.dart` | — | |
| Order status stream (Preparing → Ready) | ⚠️ PARTIAL | `data/repositories/store_repository.dart` | — | `_ordersController` stream exists but `OrderingBloc._onPlaceOrder` doesn't subscribe to it. No `OrderStatus` enum progression. |
| `OrderingBloc` — cart management | ✅ IMPLEMENTED | `features/ordering/bloc/ordering_bloc.dart` | — | |
| `OrderingBloc` — `SearchProductsEvent` | ❌ MISSING | `features/ordering/bloc/ordering_event.dart` | 🟡 P1 | Catalog search delegates to `setState` in the widget; BLoC should own search state. |
| `Product` model | ✅ IMPLEMENTED | `features/ordering/models/product_model.dart` | — | |
| `CartItem` model | ✅ IMPLEMENTED | `features/ordering/models/product_model.dart` | — | |
| `Order` model | ❌ MISSING | No `features/ordering/models/order_model.dart` | 🟡 P1 | Orders are stored as `Map<String, dynamic>` — should have a typed `Order` model with `OrderStatus` enum. |
| Customer widget tests (cart, checkout) | ❌ MISSING | No `test/features/ordering/` | 🟡 P1 | |
| Integration test for order lifecycle | ❌ MISSING | No integration test | 🔴 P0 | Place order → stream yields `Preparing` → `Ready`. |

---

## 3. Barista Module (Table Grid, Sessions, Order Queue, Shot Timer)

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| `BaristaDashboardScreen` (table grid + order queue) | ✅ IMPLEMENTED | `features/barista/screens/barista_dashboard.dart` | — | |
| `TableSessionScreen` (session detail, start/close) | ⚠️ PARTIAL | `features/barista/screens/table_detail_page.dart` | — | Screen exists; but `BaristaBloc` has no `StartTableSessionEvent` — only `UpdateTableStatusEvent`. |
| `TableStatus` enum | ✅ IMPLEMENTED | `features/barista/models/table_session_model.dart` | — | |
| QR scan → session link | ✅ IMPLEMENTED | `features/barista/screens/scan_table_qr.dart` | — | |
| Shot timer widget | ✅ IMPLEMENTED | `shared/widgets/shot_timer.dart` | — | |
| Order queue from `StoreRepository` | ⚠️ PARTIAL | `data/repositories/store_repository.dart` | — | `_ordersController` stream exists but `BaristaBloc` never subscribes to it. `BaristaBloc` only reads `_tasks` and `_tables`. |
| `BaristaBloc` — order status update (mark Ready) | ❌ MISSING | `features/barista/bloc/barista_bloc.dart` | 🔴 P0 | No event for barista to mark order `Preparing` or `Ready`. |
| Table session billing | ⚠️ PARTIAL | `features/barista/screens/active_tables_billing.dart` | — | UI exists; no billing calculation in BLoC. |
| Barista widget tests (mark order Ready) | ❌ MISSING | No `test/features/barista/` | 🟡 P1 | |
| `ExtractionTaskBloc` | ❌ MISSING | No `features/barista/bloc/` extraction bloc | 🟢 P2 | Shot timer needs its own bloc for complex timer state. |

---

## 4. Admin Module (KPIs, Inventory, Roster, Support Queue)

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| `AdminDashboardScreen` (KPI cards + sparklines) | ✅ IMPLEMENTED | `features/admin/screens/manager_dashboard.dart` | — | |
| `InventoryStatusPage` | ✅ IMPLEMENTED | `features/admin/screens/inventory_status.dart` | — | |
| `InventoryItem` model | ✅ IMPLEMENTED | `features/admin/models/inventory_item_model.dart` | — | |
| Low-stock alert triggers | ⚠️ PARTIAL | `inventory_status.dart` renders `progress < 0.3` | — | Logic exists but not triggered when customer places order. |
| `reorderItem` method | ❌ MISSING | `data/repositories/store_repository.dart` | 🟡 P1 | No method to increase inventory quantity or mark reorder. |
| Inventory stream updates on order placement | ❌ MISSING | `data/repositories/store_repository.dart` | 🔴 P0 | When `OrderingBloc._onPlaceOrder` runs, no inventory is decremented. |
| `InventoryBloc` | ❌ MISSING | No `features/admin/bloc/inventory_bloc.dart` | 🟡 P1 | Admin should have dedicated inventory management bloc. |
| `EmployeeManagementPage` | ✅ IMPLEMENTED | `features/admin/screens/employee_management.dart` | — | |
| `Employee` model | ✅ IMPLEMENTED | `features/admin/models/employee_model.dart` | — | |
| Shift toggle (ON/OFF) | ⚠️ PARTIAL | `features/admin/screens/employee_management.dart` | — | UI exists; `AdminBloc` has no `ToggleShiftEvent`. |
| `SupplierDirectoryPage` | ✅ IMPLEMENTED | `features/admin/screens/supplier_directory.dart` | — | |
| `PurchaseOrderPage` | ✅ IMPLEMENTED | `features/admin/screens/purchase_order.dart` | — | |
| `CustomerRequestsPage` (support queue) | ✅ IMPLEMENTED | `features/admin/screens/customer_requests.dart` | — | |
| `AdminBloc` — `ResolveRequestEvent` | ✅ IMPLEMENTED | `features/admin/bloc/admin_bloc.dart` | — | |
| `AdminBloc` — KPI data | ⚠️ PARTIAL | `admin_bloc.dart` | — | KPI revenue/basket are mock-derived; no live data. |
| Admin unit tests | ❌ MISSING | No `test/features/admin/` | 🟡 P1 | |

---

## 5. Real-Time Synchronization & Repository Pattern

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| `StoreRepository` singleton | ✅ IMPLEMENTED | `data/repositories/store_repository.dart` | — | |
| `ordersStream` | ⚠️ PARTIAL | `_ordersController` exists | — | Stream exists but no BLoC subscribes to it. |
| `tableStream` | ✅ IMPLEMENTED | `_tableController` | — | |
| `inventoryStream` | ❌ MISSING | No `StreamController<List<InventoryItem>>` | 🔴 P0 | Inventory changes don't propagate. |
| `sessionsStream` | ✅ IMPLEMENTED | `_tableController` | — | |
| `loyaltyStream` | ❌ MISSING | No loyalty stream | 🟢 P2 | |
| Order placement → inventory decrement | ❌ MISSING | `store_repository.dart` | 🔴 P0 | `addOrder()` doesn't reduce inventory. |
| Order placement → barista queue update | ⚠️ PARTIAL | `_ordersController.add()` exists | — | BaristaBloc doesn't subscribe. |
| In-memory adapter for offline dev | ⚠️ PARTIAL | Mock data in `StoreRepository` | — | Works for dev but no swap mechanism for real `ApiService`. |

---

## 6. Navigation & Route Guards

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| GoRouter setup | ✅ IMPLEMENTED | `routes/app_router.dart` | — | All routes defined. |
| Typed route names | ⚠️ PARTIAL | Uses string literals | — | Should use `enum AppRoutes { splash, welcome, ... }` for type safety. |
| Role-based `redirect` guard | ❌ MISSING | `app_router.dart` | 🔴 P0 | No guard blocks unauthenticated users from accessing protected routes. |
| Deep links: `OrderTracking` | ⚠️ PARTIAL | Route exists | — | Route `/tracking` exists but no shell route for deep linking context. |
| Deep links: `TableSession` | ⚠️ PARTIAL | Route `/ordering` with `data` extra | — | |

---

## 7. UI Component Library & Theming

| Item | Status | File | Priority | Acceptance Criteria |
|------|--------|------|----------|---------------------|
| `AppGlassContainer` | ⚠️ PARTIAL | `shared/widgets/glass_container.dart` | — | Exists; `hasRimLight` is named `hasInnerBorder`. Missing explicit `rimOpacity` param (UI_UX says "1px stroke"). |
| `KPICard` | ✅ IMPLEMENTED | `shared/widgets/kpi_card.dart` | — | |
| `CustomButton` | ✅ IMPLEMENTED | `shared/widgets/custom_button.dart` | — | |
| `CustomTextField` | ✅ IMPLEMENTED | `shared/widgets/custom_textfield.dart` | — | |
| `AppTheme` | ✅ IMPLEMENTED | `core/theme/app_theme.dart` | — | |
| `AppColors` | ✅ IMPLEMENTED | `core/theme/app_colors.dart` | — | Colors match UI_UX_BRIEF.md. |
| `AppTypography` | ✅ IMPLEMENTED | `core/theme/app_typography.dart` | — | |
| Responsive units (`.w`, `.h`, `.sp`) | ✅ IMPLEMENTED | Used throughout | — | |
| Manrope font (headlines) | ⚠️ PARTIAL | In `pubspec.yaml` via `google_fonts` | — | `AppTypography` should explicitly use `fontFamily: 'Manrope'`. |
| Bottom nav bar | ✅ IMPLEMENTED | `shared/widgets/bottom_nav_bar.dart` | — | |

---

## 8. Data Models

| Item | Status | File | Priority |
|------|--------|------|----------|
| `Product` | ✅ IMPLEMENTED | `features/ordering/models/product_model.dart` | — |
| `CartItem` | ✅ IMPLEMENTED | `features/ordering/models/product_model.dart` | — |
| `Order` | ❌ MISSING | No typed `Order` model | 🟡 P1 |
| `TableSession` | ✅ IMPLEMENTED | `features/barista/models/table_session_model.dart` | — |
| `InventoryItem` | ✅ IMPLEMENTED | `features/admin/models/inventory_item_model.dart` | — |
| `CustomerRequest` | ✅ IMPLEMENTED | `features/admin/models/customer_request_model.dart` | — |
| `Employee` | ✅ IMPLEMENTED | `features/admin/models/employee_model.dart` | — |
| `User` | ❌ MISSING | No user model | 🔴 P0 |
| `Address` | ❌ MISSING | No address model | 🟢 P2 |
| `PaymentMethod` | ❌ MISSING | No payment model | 🟢 P2 |
| `LoyaltyAccount` | ❌ MISSING | No loyalty model | 🟢 P2 |

---

## 9. Testing

| Item | Status | File | Priority |
|------|--------|------|----------|
| BLoC unit tests (Auth) | ❌ MISSING | No `test/features/auth/` | 🔴 P0 |
| BLoC unit tests (Ordering) | ❌ MISSING | No `test/features/ordering/` | 🔴 P0 |
| BLoC unit tests (Barista) | ❌ MISSING | No `test/features/barista/` | 🟡 P1 |
| BLoC unit tests (Admin) | ❌ MISSING | No `test/features/admin/` | 🟡 P1 |
| Widget tests (auth flow) | ❌ MISSING | `test/widget_test.dart` has only 1 smoke test | 🔴 P0 |
| Widget tests (cart, checkout) | ❌ MISSING | No `test/features/ordering/` | 🔴 P0 |
| Widget tests (barista mark Ready) | ❌ MISSING | No `test/features/barista/` | 🟡 P1 |
| Integration test (order lifecycle) | ❌ MISSING | No integration test | 🔴 P0 |
| `test_helpers.dart` | ⚠️ PARTIAL | `test/test_helpers.dart` exists | — | Provides mock HTTP + BLoC wrapper but missing `AuthBloc` in providers. |
| Test coverage target | ❌ MISSING | No coverage config | 🟡 P1 |

---

## 10. CI/CD & Build

| Item | Status | File | Priority |
|------|--------|------|----------|
| GitHub Actions CI workflow | ❌ MISSING | No `.github/workflows/` | 🔴 P0 |
| `flutter analyze` pass | ⚠️ PARTIAL | Not verified | — |
| `flutter test` pass | ⚠️ PARTIAL | Not verified | — |
| `flutter format` pass | ⚠️ PARTIAL | Not verified | — |
| Android build config | ⚠️ PARTIAL | Placeholder only | — |
| iOS build config | ⚠️ PARTIAL | Placeholder only | — |
| `RELEASE_CHECKLIST.md` | ❌ MISSING | No release doc | 🟡 P1 |
| `ASSETS_TODO.md` | ❌ MISSING | No asset manifest | 🟢 P2 |

---

## 11. Critical Bug

### 🔴 `AuthBloc` Injection Mismatch
**File:** `lib/core/utils/service_locator.dart:20`
```dart
sl.registerLazySingleton(() => AuthBloc()); // ❌ Takes no args
```
**But in `main.dart:26`:**
```dart
BlocProvider(create: (_) => di.sl<AuthBloc>()) // ✅ Uses factory pattern
```
`AuthBloc()` is a zero-arg constructor, so `registerLazySingleton` happens to work here. However, **this is fragile** — if `AuthBloc` is later refactored to accept `AuthRepository`, `registerLazySingleton` will fail while `registerFactory` won't. Should use `registerFactory` consistently since `main.dart` treats it as a factory.

---

## Implementation Plan (PR-Sized Tasks)

| # | Branch Name | Task | Priority | Effort |
|---|-------------|------|----------|--------|
| 1 | `fix/auth-injection-bug` | Fix `AuthBloc` injection (factory vs singleton), create `User` model, `AuthRepository` | 🔴 P0 | Medium |
| 2 | `feat/auth-complete-flow` | Complete auth events (Register, OTP, Reset, Logout) + role guards in router | 🔴 P0 | Medium |
| 3 | `feat/catalog-search-bloc` | Add `SearchProductsEvent` to `OrderingBloc`, promo code support | 🟡 P1 | Small |
| 4 | `feat/customize-cart-wire` | Wire `CustomizeBrewPage` → `AddToCartEvent` with customization + price update | 🟡 P1 | Small |
| 5 | `feat/store-repo-streams` | Add `inventoryStream`, `orderStatusStream`, order→inventory decrement, barista subscription | 🔴 P0 | Medium |
| 6 | `feat/barista-order-queue` | Add `UpdateOrderStatusEvent` to `BaristaBloc`, subscribe to `ordersStream` | 🔴 P0 | Small |
| 7 | `feat/admin-inventory-bloc` | Add `InventoryBloc`, `reorderItem`, `ToggleShiftEvent`, KPI data methods | 🟡 P1 | Medium |
| 8 | `feat/order-model` | Create typed `Order` model with `OrderStatus` enum | 🟡 P1 | Small |
| 9 | `feat/tests-p0` | Unit tests for all 4 BLoCs, widget tests for auth + checkout | 🔴 P0 | Medium |
| 10 | `chore/ci-and-release` | CI workflow, `RELEASE_CHECKLIST.md`, `ASSETS_TODO.md` | 🟡 P1 | Small |
| 11 | `feat/glass-container-polish` | Polish `AppGlassContainer` rim lighting per UI_UX spec | 🟢 P2 | Small |
| 12 | `feat/enum-routes` | Typed route names enum for GoRouter | 🟢 P2 | Small |

---

## Assumptions

1. **No real backend** — all API calls are mocked via `Future.delayed`. The `ApiService` is wired but returns hardcoded responses.
2. **Payment is a mock** — no actual payment processing. Checkout screens are UI-only.
3. **No biometric auth** — placeholder only.
4. **No localization** — all strings are English.
5. **No actual QR scanning** — `ScanTableQRPage` simulates scan via a button tap.
6. **Manrope font** — loaded via `google_fonts` package (in `pubspec.yaml`).

---

*End of gap report.*
