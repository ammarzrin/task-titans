# 01. Frontend Plan: UI Design Phase

This document outlines key questions and considerations for the UI Design Phase of the Task Titans application. Addressing these points will help define the overall look, feel, and user experience of the Flutter frontend.

## 1. Overall Look and Feel

*   **Aesthetic Style:** Playful and minimalist.
*   **Color Palette:** **Primary & Pastel Blend** (Bright, energetic primary colors for accents/interactive elements; softened pastel tones for backgrounds).
*   **Typography:**
    *   **Headings:** `Balsamiq Sans` (Hand-drawn, sketchbook charm).
    *   **Body Text:** `Open Sans` (Clean, minimalist readability).
*   **Iconography:** Filled and cartoonish, utilizing **SVG assets** for crisp scaling.
*   **Imagery/Illustrations:** Custom playful illustrations with a sketchbook/notebook appearance.

## 2. User Experience (UX) Principles

*   **Ease of Use:**
    *   **General:** Clear visual hierarchy and intuitive navigation patterns.
    *   **Children:** Large tap targets, icon-heavy interface with minimal text, and direct manipulation.
*   **Engagement:**
    *   **Priorities:**
        1.  **Simple Personalization:** Hero Avatar selection.
        2.  **Consistent Narrative:** Thematic integration (Quests, Heroes, Gold).
        3.  **Dynamic Progress Visualization:** Animated bars, visual rewards (coins/stars).
*   **Accessibility:**
    *   **Focus Areas:** Robust Color Contrast, Dynamic Type/Scalable Font Sizes, Reinforced Tap Target Size (min 48x48dp), and Information Conveyance Beyond Color.
*   **Responsiveness:**
    *   **Primary Target:** Mobile phones in **portrait orientation**.
    *   **Strategy:** Adaptive layouts for different phone screen sizes; Tablet support is secondary.

## 3. Core Feature UI/UX

### Admin Dashboard (Parents)

*   **Quest Creation/Management:**
    *   **Workflow:** FAB -> Modal Form.
    *   **Inputs:** Title, Description, **Difficulty Presets** (Easy, Medium, Hard, Epic - auto-sets XP/Gold), **Icon Selection** (Grid of SVG icons), Assignment (Default: "General Pool", Optional: Specific Child), Due Date, Recurrence.
    *   **Approval:** "Pending Approvals" section. Simple "Mark as Done" by child (optional text note) -> Parent approves/rejects. No complex per-quest proof settings.
*   **Child/Hero Profile Management:**
    *   **Security:** **PIN Code System** for ALL profiles (Parents and Children) to switch users.
    *   **Creation:** Name, Initial Avatar (Parent picks), PIN.
    *   **Management:** "Hero Card" view (Stats, History). **No manual adjustment** of Gold/XP for MVP.
*   **Reward Shop Customization:**
    *   **Workflow:** "Create Reward" FAB.
    *   **Inputs:** Title, Cost (Gold), Icon, **Stock Limit Toggle** (Unlimited vs. Finite number).

### Hero Dashboard (Children)

*   **Quest Browsing/Claiming:**
    *   **Display:** **Grid of "Quest Cards"** (Icon, Title, Difficulty, Reward).
    *   **Logic:** **"Claim First"** mechanism. Child sees "Pool" -> Taps "Accept" -> Quest moves to "My Quests" tab -> Child marks done.
*   **Progress Tracking:**
    *   **Hero Stats:** Top of dashboard *always* displays Avatar, Level (big number), XP Bar, and Current Gold.
*   **Custom Redemption Shop:**
    *   **Flow:** Grid display -> Tap to Buy -> Gold deducted **instantly** -> Item moves to **"Inventory"** (My Loot).
    *   **Fulfillment:** Child shows Inventory to parent for real-world reward -> Parent removes/archives item from their dashboard to clear it.

### Family Leaderboard

*   **Display:** Ranked list of family members by total XP.

## 4. Age-Specific UI/Features

*   **Strategy:** **Standardized UI for MVP.**
    *   The interface will be kept simple and icon-heavy (accessible for ~5-12 years).
    *   Differentiation will come from **Quest Content/Difficulty** rather than changing the UI layout. Complex age-gating is deferred.

## 5. Flutter Specifics

*   **State Management:** **Riverpod**. Chosen for its safety, testability, and robust handling of user sessions and global state.
*   **Navigation:** **GoRouter**. Chosen for its deep linking capabilities and easy management of complex stacks (Login -> Family -> Dashboard).
*   **Theming:** Consistent implementation of the "Primary & Pastel" palette and "Balsamiq/Open Sans" typography via `ThemeData`.
*   **Animations:** Focus on micro-interactions (button presses, success particles) and standard page transitions.

## 6. Pre-MVP UI Mockups/Wireframes

*   **Tooling:** Figma.
*   **Key Screens:**
    1.  **Login/Family Setup** (Pin Entry).
    2.  **Parent Dashboard** (Quest List, Pending Approvals).
    3.  **Child Dashboard** (Hero Card, Quest Grid).
    4.  **Child "My Quests"** (Active missions).
    5.  **Redemption Shop View** (Grid of rewards).
    6.  **Child Inventory** (Redeemed/Active rewards).
    7.  **Quest Creation Form** (The presets UI).
