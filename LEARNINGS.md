# Project Learnings: Bean & Brew OS

## Technical Patterns
- **Glassmorphism in Flutter:** Combining `BackdropFilter` with `CustomPaint` (for 1px gradient borders) produces the most accurate replication of high-fidelity glass designs.
- **Dynamic Repository Sync:** Using a singleton `StoreRepository` allows for immediate UI updates across different user modules (e.g., placing an order in 'Customer' immediately appearing in 'Barista').
- **ScreenUtil Discipline:** Strict adherence to `.w`, `.h`, and `.sp` extensions is critical for maintaining pixel-perfect parity on variable Android device aspect ratios.

## Stitch-to-Flutter Conversion
- **Design Tokens:** Directly extracting HEX codes and typography scales from Stitch `designMd` ensures 100% color and text accuracy.
- **Component Hierarchies:** Replicating the HTML/CSS structure with nested `Column` and `Stack` widgets accurately preserves the "floating" nature of luxury UI designs.
