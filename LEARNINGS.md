# Learnings & Implementation Patterns: Bean & Brew OS

## 1. Responsive Design System
Implementing the **Stitch-to-Flutter** pipeline required a strict adherence to `flutter_screenutil`.
- **Pattern:** Never use raw `double` for dimensions.
- **Result:** The UI scales perfectly from a 5.5" Android phone to a 12.9" iPad without changing code.

## 2. Advanced Layouts with Slivers
One of the key technical hurdles was resolving "Sliver inside Box" errors in the `ProductDetailsPage`.
- **Learning:** When creating immersive headers that overlap content, `CustomScrollView` with `SliverToBoxAdapter` is the only stable way to handle complex scrolling without layout crashes.
- **Pattern:** Using `SliverFillRemaining(hasScrollBody: false)` for full-screen glassmorphic backgrounds.

## 3. Real-time Cross-Module Synchronization
To make the app feel "OS-like", data had to move instantly between the Customer and Barista modules.
- **Pattern:** Shared singleton `StoreRepository` injected via `service_locator`.
- **Effect:** A customer placing an order instantly triggers the "BREWING" status on the Barista Dashboard without needing a manual refresh or network delay.

## 4. Visual Fidelity (Glassmorphism)
Achieving the obsidian-themed luxury look required custom `BackdropFilter` widgets.
- **Pattern:** `AppGlassContainer` widget with `BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10))`.
- **Optimization:** Limiting blur sigmas to 10 for performance while maintaining visual depth.

## 5. Automated Testing for UI
Mocking network images and HTTP clients was essential for a stable CI/CD pipeline.
- **Solution:** Custom `MockHttpOverrides` to return a 1x1 transparent PNG for every network request, preventing test timeouts and 403 errors in headless environments.
