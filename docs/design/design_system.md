# Task Titans Design System

This document serves as the single source of truth for the visual design and user experience of **Task Titans**. It defines the "Comic Book / Superhero Pop" aesthetic and provides technical specifications for implementation in Flutter.

---

## 1. Brand Identity

*   **Core Concept:** "Every Chore is a Mission. Every Child is a Titan."
*   **Visual Style:** **Comic Book Pop Art**. Bold, energetic, high-contrast, and empowering. It blends the nostalgia of classic comics with modern, clean mobile UI patterns.
*   **Voice & Tone:**
    *   **Exciting:** Use exclamation points and action verbs ("Claim!", "Complete!", "Redeem!").
    *   **Encouraging:** Focus on progress and ability ("You are Level 5!", "Great job!").
    *   **Direct:** Keep instructions short and punchy, like comic panel narration.

---

## 2. Color System ("Power Pop")

We use a vibrant, high-saturation palette anchored by thick black outlines.

### Primary Colors
Used for main actions, branding, and key UI elements.

| Role | Color Name | Hex Code | Usage |
| :--- | :--- | :--- | :--- |
| **Primary Brand** | **Electric Blue** | `#0056FF` | Primary buttons, headers, active tabs, links. |
| **Action / Alert** | **Vigilante Red** | `#FF1D25` | "Create Mission" FAB, Delete actions, Notification badges, High-priority alerts. |
| **Currency / Reward**| **Lightning Yellow**| `#FFD700` | Gold icons, XP bars, Reward highlights, "Call to Action" backgrounds. |

### Secondary & Neutrals
Used for text, backgrounds, and borders.

| Role | Color Name | Hex Code | Usage |
| :--- | :--- | :--- | :--- |
| **Ink (Outline)** | **Comic Black** | `#000000` | **Borders**, Icons, Headings, Hard Shadows. (Avoid pure black for large backgrounds). |
| **Paper (Bg)** | **Pure White** | `#FFFFFF` | Card backgrounds, Input fields. |
| **Canvas** | **Halftone Grey** | `#F5F5F5` | App background (often overlaid with a dot pattern). |
| **Text (Body)** | **Midnight Grey** | `#1A1A1A` | Body text, descriptions (softer than pure black). |

### Semantic Colors
Used for feedback states.

| Role | Color Name | Hex Code | Usage |
| :--- | :--- | :--- | :--- |
| **Success** | **Hulk Green** | `#22E23B` | "Mission Complete", Success toasts, Checkmarks. |
| **Warning** | **Orange Alert** | `#FF8800` | Due soon, low stock. |
| **Error** | **Vigilante Red** | `#FF1D25` | Form errors (Same as Action Red). |

---

## 3. Typography

We use two distinct typefaces to separate "Flavor" from "Content".

### Font Families

*   **Headings:** **`Bungee`** (Google Font).
    *   *Style:* Geometric, heavy, urban, all-caps feeling (even in lowercase).
    *   *Usage:* Screen titles, Button labels, Big stats, Mission titles.
*   **Body:** **`Nunito`** (Google Font).
    *   *Style:* Rounded sans-serif. Friendly and highly legible.
    *   *Usage:* Descriptions, lists, inputs, small labels.

### Type Scale

| Style | Font | Size (sp) | Weight | Line Height | Case |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **H1 (Hero)** | Bungee | 32 | Regular | 1.1 | Uppercase preferred |
| **H2 (Title)** | Bungee | 24 | Regular | 1.2 | Sentence/Title |
| **H3 (Subtitle)**| Bungee | 20 | Regular | 1.2 | Sentence/Title |
| **Body Large** | Nunito | 18 | Bold (700)| 1.5 | Sentence |
| **Body Medium**| Nunito | 16 | SemiBold (600)| 1.5 | Sentence |
| **Caption** | Nunito | 14 | Bold (700)| 1.4 | Sentence |
| **Button** | Bungee | 16 | Regular | 1.0 | Uppercase |

---

## 4. Shape & Form (The "Sticker" Look)

The defining characteristic of this design system is the combination of **Thick Borders**, **Rounded Corners**, and **Hard Shadows**.

### Borders
Every container, button, and card must have a visible border to mimic a comic panel or sticker.
*   **Width:** `2px` (Standard) or `3px` (Featured elements).
*   **Color:** `#000000` (Comic Black).

### Corner Radius
*   **Small (Buttons/Inputs):** `12px`
*   **Medium (Cards):** `16px`
*   **Large (Modals/Sheets):** `24px`
*   **Circle:** `50%` (Avatars, Icon containers).

### Shadows ("Hard Shadow")
We do **not** use blurry drop shadows. We use a solid, offset block of black to create a pop-out 3D effect.
*   **CSS/Flutter Logic:**
    *   Color: `#000000`
    *   Offset: `X: 4, Y: 4` (or `X: 2, Y: 2` for small items).
    *   Blur Radius: `0` (Critical for the look).
*   **Interaction:** On press, the shadow offset reduces to `0` (translating the button down 4px) to simulate being physically pushed.

---

## 5. Layout & Spacing

*   **Grid System:** 8pt Grid. All spacing, margins, and sizing should be multiples of 8 (8, 16, 24, 32, 48).
*   **Page Margins:** `24px` (Mobile Portrait). The UI should feel "chunky" and not too edge-to-edge.
*   **Gutters:** `16px` between grid items (e.g., Mission Cards).

---

## 6. Component Library

### Buttons
*   **Primary Action (CTA):**
    *   Background: Electric Blue or Lightning Yellow.
    *   Text: Bungee, White or Black (contrast dependent).
    *   Border: 3px Black.
    *   Shadow: Hard Black (4px).
*   **Secondary Action:**
    *   Background: White.
    *   Text: Bungee, Electric Blue.
    *   Border: 2px Black.
    *   Shadow: Hard Black (2px).
*   **Destructive:**
    *   Background: Vigilante Red.
    *   Text: Bungee, White.

### Cards (Mission/Hero)
*   Background: White.
*   Border: 2px Black.
*   Shadow: Hard Black (4px).
*   **Content Layout:**
    *   **Icon:** Left or Top-Center (Large SVG).
    *   **Title:** H3 (Bungee).
    *   **Badges:** Difficulty stars or Gold reward pill on top-right.

### Inputs (Text Fields)
*   Background: White.
*   Border: 2px Black.
*   Corner Radius: 12px.
*   **Focused State:** Border Color changes to Electric Blue, Shadow appears (Hard, 4px).
*   **Label:** Bungee (small) above the field.

### Bottom Navigation
*   Background: White with Top Border (2px Black).
*   **Selected Item:** Icon scales up (1.2x), colored Electric Blue.
*   **Unselected Item:** Icon Black/Grey.
*   **Font:** No labels (Icon only) or very small Bungee labels.

---

## 7. Iconography & Assets

*   **Style:** **Filled + Outlined**.
    *   Icons should look like patches or stickers.
    *   Solid fill color (usually White, Yellow, or Blue) with a `2px` Black stroke.
*   **Source:** Use libraries like **Lucide** or **FontAwesome** (Solid), but apply a stroke effect in code, OR use custom SVG assets with pre-drawn outlines.
*   **Imagery:**
    *   **Halftone Patterns:** Use subtle dot patterns (opacity 10-20%) on backgrounds to add texture without noise.
    *   **Bursts:** Use "Star" or "Explosion" shapes behind rewards or level-up notifications.

---

## 8. Animation Principles

*   **Bouncy:** Elements should spring into place. Use `Curves.elasticOut` for modals and popups.
*   **Page Transitions:** "Slide & Stack". New screens slide in from the right with a black border, sliding *over* the previous screen like a comic panel.
*   **Micro-interactions:**
    *   **Button Press:** Button physically moves down and right to cover its shadow.
    *   **Checkmark:** Explodes with a particle effect (confetti/stars) when a mission is done.
