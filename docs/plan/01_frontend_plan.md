# 01. Frontend Plan: UI Design Phase

This document outlines key questions and considerations for the UI Design Phase of the Task Titans application. Addressing these points will help define the overall look, feel, and user experience of the Flutter frontend.

## 1. Overall Look and Feel

*   **Aesthetic Style:** **Comic Book / Superhero Pop** (Energetic, bold, dynamic).
*   **Color Palette:** **"Power Pop"**
    *   **Primary:** Electric Blue, Vigilante Red, Lightning Yellow.
    *   **Accents:** Bold **Black Outlines** to give a "drawn" feel.
    *   **Backgrounds:** Clean white or subtle halftone dot patterns.
*   **Typography:**
    *   **Headings:** `Bungee` (Bold, geometric, urban/comic feel).
    *   **Body Text:** `Nunito` (Rounded, friendly, and highly readable).
*   **Iconography:** **Boldly Outlined SVGs**. Icons should look like "stickers" or patches with thick strokes.
*   **Imagery/Illustrations:** Comic-inspired elements: Speed lines, speech bubbles, starburst shapes for rewards ("POW!"), and superhero motifs.

## 2. User Experience (UX) Principles

*   **Ease of Use:**
    *   **General:** Clear visual hierarchy with bold distinct sections.
    *   **Children:** Large, "punchy" buttons (like big comic panels), icon-heavy interface.
*   **Engagement:**
    *   **Theme:** **"Become a Titan."** Framing chores as "Missions" and leveling up as "Gaining Rank/Superpowers."
    *   **Priorities:**
        1.  **Simple Personalization:** Hero Avatar (Superhero style).
        2.  **Consistent Narrative:** "Task Titans" universe.
        3.  **Dynamic Progress Visualization:** XP Bars that fill up like energy meters, animated comic bursts for completion.
*   **Accessibility:**
    *   **Focus Areas:** High contrast (inherent in the comic style), scalable fonts, and clear focus indicators (thick borders).
*   **Responsiveness:**
    *   **Primary Target:** Mobile phones in **portrait orientation**.
    *   **Strategy:** Adaptive layouts; keeping the "comic panel" look consistent across sizes.

## 3. Core Feature UI/UX

### Admin Dashboard (Parents)

*   **Quest Creation/Management:**
    *   **Workflow:** FAB -> Modal Form.
    *   **Inputs:** Title, Description, **Difficulty Presets** (Easy, Medium, Hard, Epic - auto-sets XP/Gold), **Icon Selection** (Grid of superhero-themed SVGs), Assignment (Default: "General Pool", Optional: Specific Child), Due Date, Recurrence.
    *   **Approval:** "Pending Approvals" section. Simple "Mark as Done" by child (optional text note) -> Parent approves/rejects.
*   **Child/Hero Profile Management:**
    *   **Security:** **PIN Code System** for ALL profiles.
    *   **Creation:** Name, Initial Superhero Avatar, PIN.
    *   **Management:** "Hero ID Card" view (Stats, History).
*   **Reward Shop Customization:**
    *   **Workflow:** "Create Reward" FAB.
    *   **Inputs:** Title, Cost (Gold), Icon, **Stock Limit Toggle**.

### Hero Dashboard (Children)

*   **Quest Browsing/Claiming:**
    *   **Display:** **Grid of "Mission Cards"** (Bold borders, Icon, Reward Stars).
    *   **Logic:** **"Claim First"** mechanism. Child sees "Mission Board" -> Claims Quest -> Moves to "My Missions".
*   **Progress Tracking:**
    *   **Hero Stats:** Top of dashboard displays Avatar, Hero Rank (Level), XP Energy Bar, and Gold Stash.
*   **Custom Redemption Shop:**
    *   **Flow:** Grid display -> Tap to Buy -> Gold deducted **instantly** -> Item moves to **"Loot Bag"** (Inventory).
    *   **Fulfillment:** Child shows Loot Bag to parent -> Parent archives item.

### Family Leaderboard

*   **Display:** Ranked list of Titans by total XP.

## 4. Age-Specific UI/Features

*   **Strategy:** **Standardized UI for MVP.**
    *   The "Comic Book" style is universally appealing (kids love superheroes, adults love the retro pop art).
    *   Differentiation via content difficulty.

## 5. Flutter Specifics

*   **State Management:** **Riverpod**.
*   **Navigation:** **GoRouter**.
*   **Theming:** Custom `ThemeData` enforcing `Bangers` for headers, `Nunito` for body, and the "Power Pop" color scheme.
*   **Animations:** "Bouncy" interactions, slide transitions (like turning a comic page), and scale animations for buttons.

## 6. Pre-MVP UI Mockups/Wireframes

*   **Tooling:** Figma.
*   **Key Screens:**
    1.  **Login/Family Setup** (Pin Entry).
    2.  **Parent Dashboard** (Mission Control).
    3.  **Child Dashboard** (Hero HQ).
    4.  **Child "My Quests"** (Active Missions).
    5.  **Redemption Shop View** (Loot Store).
    6.  **Child Inventory** (Loot Bag).
    7.  **Quest Creation Form**.
