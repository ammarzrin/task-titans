# Implementation Plan - Task Titans

This document tracks the step-by-step progress of the Task Titans implementation.

## Phase 1: Foundation (Setup & Design System)

### Project Configuration

- [x] **Clean Setup**: Remove default counter app code.
- [x] **Dependencies**: Add `flutter_riverpod`, `go_router`, `supabase_flutter`, `google_fonts`, `flutter_svg`, `flutter_animate`, `json_annotation`, `equatable`.
- [x] **Dev Dependencies**: Add `build_runner`, `json_serializable`.
- [x] **Assets**:
  - [x] Create `assets/images` and `assets/icons`.
  - [x] Configure `Bungee` and `Nunito` fonts in `pubspec.yaml`.
  - [x] Add basic placeholder SVGs (Hero avatars, Quest icons).

### Design System Implementation

- [x] **Theme Configuration**:
  - [x] Create `lib/core/theme/app_colors.dart` (Define "Power Pop" palette).
  - [x] Create `lib/core/theme/app_typography.dart` (Define Bungee/Nunito styles).
  - [x] Create `lib/core/theme/app_theme.dart` (Combine into `ThemeData`).
- [x] **Core Widgets (The "Comic Look")**:
  - [x] `ComicButton`: Generic button with thick border, hard shadow, and press animation.
  - [x] `ComicCard`: Container with thick border and hard shadow.
  - [x] `ComicTextField`: Styled input field with focus states.
  - [x] `ComicHeader`: Reusable Bungee header widget.

### Backend & Architecture Setup

- [x] **Supabase Client**: Initialize `Supabase` in `main.dart` and create a Riverpod provider.
- [x] **Folder Structure**: Set up `lib/features/`, `lib/core/`, `lib/data/`.
- [x] **Data Models**: Create `Profile`, `Family`, `Mission`, `Reward` models with `json_serializable`.

---

## Phase 2: Core Loop (Auth & Missions)

### Authentication & Profile Switching

- [x] **Repositories**: Implement `AuthRepository` (Login/Signup) and `ProfileRepository` (Fetch profiles).
- [x] **Login Screen**: Family email/password login.
- [x] **Signup Screen**: Create Family Account flow.
- [x] **Onboarding**: Admin Profile & Family Setup (Create/Join).
- [x] **Profile Selection**: Grid of avatars.
- [x] **PIN Protection**: Modal for entering 4-digit PIN to access a profile.
- [x] **State Management**: Implement `UserNotifier` to track the *current active profile*.

### Parent Dashboard ("Mission Control")

- [x] **Dashboard Layout**: Tab navigation (Missions, Rewards, Profiles).
- [x] **Mission List**: View all active/pending missions.
- [x] **Create Mission**: FAB -> Modal form with Title, Difficulty (XP/Gold logic), and Assignee.
- [x] **Approval System**: View "Pending" tasks -> Approve (Grant XP/Gold) or Reject.
- [x] **Profile Management**: View Squad, Add Child, Logout.

### Child Dashboard ("Hero HQ")

- [ ] **Hero Stats**: Header showing Avatar, Level, XP Bar, and Gold.
- [ ] **Mission Board**: View available missions (General + Personal).
- [ ] **Mission Interaction**:
  - [ ] "Claim": Assign mission to self.
  - [ ] "Complete": Mark as done (updates status to `pending_approval`).

---

## Phase 3: The Economy & Polish

### Rewards & Shop

- [ ] **Reward Repository**: CRUD for rewards.
- [ ] **Shop UI (Parent)**: Create/Delete Rewards.
- [ ] **Shop UI (Child)**: Grid of buyable items.
- [ ] **Purchase Logic**:
  - [ ] Call Supabase RPC `purchase_reward`.
  - [ ] Update local Gold/Inventory state.
- [ ] **Inventory UI**: View purchased items ("Loot Bag").
- [ ] **Fulfillment**: Parent "archives" used items.

### Gamification & UX Polish

- [ ] **Animations**:
  - [ ] Button press "squish".
  - [ ] Page transitions (Slide & Stack).
  - [ ] XP Bar fill animation.
  - [ ] Success burst/confetti on mission completion.
- [ ] **Error Handling**: Friendly error toasts/snackbars.
- [ ] **Empty States**: Fun comic-style illustrations for empty lists.

### Final Verification

- [ ] **Integration Testing**: Verify flow from Parent Create -> Child Complete -> Parent Approve.
- [ ] **Linting & Cleanup**: Run `flutter analyze` and fix issues.
