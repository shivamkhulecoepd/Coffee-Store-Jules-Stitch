# Implementation Plan — Bean & Brew OS

## 1. Technical Stack
- **Framework:** Flutter (Stable channel).
- **Architecture:** Clean Architecture with Feature-based modularization.
- **State Management:** BLoC (flutter_bloc) for business logic and state transitions.
- **Dependency Injection:** GetIt (sl) for service discovery and repository singletons.
- **Navigation:** GoRouter for declarative, type-safe routing.
- **UI Responsiveness:** flutter_screenutil.

## 2. Directory Structure
```text
lib/
├── core/               # App-wide themes, constants, and utilities
├── data/               # Centralized repositories and data sources
├── features/           # Feature modules (Auth, Ordering, Barista, Admin, etc.)
│   ├── [feature]/
│   │   ├── bloc/       # State management logic
│   │   ├── models/     # Data entities
│   │   ├── screens/    # UI Pages
│   │   └── widgets/    # Feature-specific reusable components
└── shared/             # Global reusable widgets (GlassContainer, Buttons, etc.)
```

## 3. Data Strategy
- **Repository Pattern:** A centralized `StoreRepository` acts as the single source of truth for the application's runtime state.
- **Synchronization:**
  - Singleton repository pattern ensures all modules access the same underlying data sets (Inventory, Orders, Sessions).
  - Stream-based updates in the repository allow BLoCs to react to changes made in other parts of the app (e.g., Barista status change reflecting in Customer tracking).
- **Model Integrity:** Models use Equatable for efficient rebuilds and value-based comparisons in BLoC states.

## 4. Implementation Phases

### Phase 1: Core & Foundation
- Setup `ScreenUtil` and base `AppTheme`.
- Implement `sl` (Service Locator) and basic `StoreRepository`.
- Create shared UI library (Glass containers, artisanal typography).

### Phase 2: Feature Development (Modular)
- **Authentication:** Role-based logic and onboarding screens.
- **Customer Experience:** Catalog implementation, product customization, and checkout flow.
- **Barista Operations:** Table session management and extraction task workflows.
- **Admin Management:** KPI dashboards, inventory status, and roster management.

### Phase 3: Integration & Sync
- Wiring real-time interactions (Ordering -> Barista updates).
- Implementing global search and artisanal filtering logic.
- Finalizing navigation transitions and hero animations.

### Phase 4: Audit & QA
- Comprehensive visual audit against Stitch designs.
- Responsiveness testing across multiple device breakpoints.
- Unit and widget testing for core business flows using `test_helpers.dart`.

## 5. Testing Approach
- **Widget Testing:** Verify UI component rendering and interaction logic.
- **Integration Testing:** Ensure repository-to-bloc-to-ui data flow is consistent.
- **Mocking Strategy:** Use custom HTTP overrides and bloc providers in tests to simulate network assets and repository states.
