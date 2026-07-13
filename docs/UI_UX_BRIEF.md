# UI/UX Brief Document — Bean & Brew OS

## 1. Design Philosophy: "Luxury Modern"
The aesthetic is centered on a high-end, sophisticated, and tactile experience. It combines the warmth of a premium coffeehouse with the precision of modern technological tools.

## 2. Visual Style: Glassmorphism
- **Backdrop Blur:** All cards and navigation panels utilize a `24px` to `40px` background blur to create depth.
- **Surface Opacity:** Obsidian backgrounds (#131313) are layered with 80% opaque glass containers (#1D1D1D).
- **Rim Lighting:** 1px stroke gradients from translucent white to transparent are applied to simulate light catching the edges of glass sheets.
- **Floating Logic:** Elements are designed to hover above a deep, infinite background, never sitting flush against edges.

## 3. Color Palette
- **Obsidian (#131313):** Foundational background color.
- **Accent Taupe (#E2C4A9):** Primary interactive color, reminiscent of steamed milk.
- **Crema (#F4ECE2):** Soft bone-white for high-legibility text and delicate highlights.
- **Espresso Bold (#2D1E17):** Deep rich brown for sub-containers and thematic depth.
- **Success/Error:** Muted yet distinct tones integrated harmoniously into the dark theme.

## 4. Typography
- **Headlines (Manrope):** Geometric and punchy. Bold weights with tight letter-spacing (-0.02em) for authority.
- **Functional Text (Inter):** Utilitarian clarity. Regular weights with generous line-heights (1.5 - 1.6) for a relaxed reading experience.
- **Utility Data:** Labels are consistently uppercase with increased letter-spacing for a sophisticated "tagged" look.

## 5. Key UI Components
- **AppGlassContainer:** The standard wrapper for all content blocks, providing the signature blur and border.
- **KPI Cards:** Large numeric indicators with subtle sparkline charts for rapid data digestion.
- **Artisanal Product Cards:** Large-scale imagery with overlayed metadata and quick-add actions.
- **Interactive Progress Bars:** "Sunken" tracks with "inflated" indicators to mimic physical material displacement.

## 6. Responsiveness Standard
- **ScreenUtil Implementation:** Mandatory use of `.w`, `.h`, `.r`, and `.sp` extensions for all dimensions.
- **Scaling Strategy:** Consistent 20px side margins on mobile, transitioning to centered 1200px max-width grids on larger displays.
- **Corner Radii:** Signature 28px radius for primary panels, scaling down to 20px on small mobile devices to preserve real estate.

## 7. Motion & Interaction
- **Smooth Transitions:** 300ms - 400ms ease-out transitions between screens.
- **Haptic Feedback Simulation:** Subtle scale-down (0.98x) and inset shadow swaps on button presses to simulate physical tactility.
- **Immersive Scrolling:** Use of immersive headers that shrink and blur upon scroll using `CustomScrollView`.
