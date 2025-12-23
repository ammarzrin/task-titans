# Task Titans - Project Progress & Guide

**Last Updated:** December 18, 2025

## 1. Project Overview

**Task Titans** is a gamified chore management app for families, built with **Flutter** and **Supabase**. It features a "Power Pop" comic book aesthetic to motivate children to complete tasks.

## 2. Current Status

**Phase 1: Foundation** is **COMPLETE**.
We have established the core infrastructure, design system, and data models required to build the application features.

---

## 3. Implementation Log

### ✅ Setup & Configuration

* **Cleaned `main.dart`**: Removed default counter app, set up `ProviderScope`.
* **Dependencies Installed**:
  * `flutter_riverpod` (State Management)
  * `supabase_flutter` (Backend)
  * `go_router` (Navigation)
  * `google_fonts` (Typography)
  * `flutter_animate` (Animations)
  * `json_serializable` (Data Parsing)
* **Assets**: configured `assets/icons` and `assets/images` with placeholders.

### ✅ Architecture

We adopted a **Feature-First Architecture** to ensure scalability.

* **`lib/core/`**: Shared resources (Theme, Router, Widgets).
* **`lib/data/`**: Data layer (Models, Repositories, Providers).
* **`lib/features/`**: Feature-specific code (Auth, Dashboard, etc.).

### ✅ Design System ("Power Pop")

Implemented the comic-book style visual language.

* **Theme**: defined in `lib/core/theme/`.
  * **Colors**: Electric Blue, Vigilante Red, Comic Black outlines.
  * **Typography**: Bungee (Headers) and Nunito (Body) - **Configured locally in `pubspec.yaml`**.
* **Core Widgets**: Created reusable "comic" components in `lib/core/widgets/`.
  * `ComicButton`: Thick borders, hard shadows, press animation.
  * `ComicCard`: Standard container with comic styling.
  * `ComicTextField`: Pop-out input fields.
  * `ComicHeader`: Standardized Bungee header.

### ✅ Data Layer

* **Supabase**: Initialized client in `main.dart` and created a global `supabaseProvider`.
* **Models**: Created Dart models in `lib/data/models/` matching the Supabase schema:
  * `Profile` (Parents & Children)
  * `Family` (Groups)
  * `Mission` (Chores)
  * `Reward` (Shop Items)
* **Repositories**: Implemented repositories to abstract Supabase calls:
  * `AuthRepository`: Handles Sign In/Up and User Sessions.
  * `ProfileRepository`: Fetches family profiles and handles profile creation.

---

## 4. Project Navigation Guide

| Directory                | Purpose             | Key Files                              |
|:------------------------ |:------------------- |:-------------------------------------- |
| **`lib/core/theme`**     | **Visual Design**   | `app_colors.dart`, `app_theme.dart`    |
| **`lib/core/widgets`**   | **UI Components**   | `comic_button.dart`, `comic_card.dart` |
| **`lib/data/models`**    | **Database Schema** | `profile.dart`, `mission.dart`         |
| **`lib/data/repositories`**| **Data Logic**    | `auth_repository.dart`                 |
| **`lib/data/providers`** | **Global State**    | `supabase_provider.dart`               |
| **`lib/features/`**      | **App Screens**     | *(Currently empty folders)*            |
| **`lib/main.dart`**      | **Entry Point**     | App initialization                     |

---

## 5. Important Notes

### ⚠️ Action Required: Code Generation

The data models use `json_serializable`. You must run the build runner to generate the `.g.dart` files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Supabase Configuration

The `Supabase.initialize` call in `lib/main.dart` currently uses placeholder strings (`YOUR_SUPABASE_URL`). These need to be replaced with actual credentials from your Supabase project settings before running the app.

---

## 6. Next Steps (Phase 3: The Economy)

1. [x] Implement **AuthRepository** and **ProfileRepository**.
2. [x] Build **Login Screen** & **Signup Screen**.
3. [x] Build **Onboarding Flow** (Profile & Family Setup).
4. [x] Build **Profile Selection** (Netflix style) with PIN.
5. [x] Implement **Parent Dashboard** Shell.
6. [x] Implement **Mission List** & **Create/Approve Mission**.
7. [x] Implement **Profile Management** (Add Child, Sign Out).
8. Implement **Rewards System** (Shop & Inventory).
9. Implement **Child Dashboard** (Hero HQ).

---

## 7. Technical Implementation Details (Recent Updates)

### 🔐 Authentication & Onboarding
*   **Onboarding Flow:** We implemented a multi-step onboarding process (`Signup` -> `Admin Setup` -> `Family Setup`).
*   **RPC Functions:** We used a Postgres Function (`create_complete_family_account`) to transactionally create a Family and Admin Profile, bypassing tricky RLS issues during initial setup.
*   **Invite Codes:** Users can join existing families using a 6-character Invite Code. We added specific RLS policies to allow querying the `families` table for this check.

### 🛡️ Security & RLS
*   **Recursive Policies:** We solved an infinite recursion bug in RLS using a `security definer` helper function `lookup_user_family_id`.
*   **Child Profiles:** We modified the schema to allow Child Profiles to exist without a corresponding Supabase Auth User (using random UUIDs).

### 📱 Parent Dashboard
*   **Navigation:** Uses `StatefulShellRoute` for persistent bottom tabs (Missions, Rewards, Profiles).
*   **Missions:** Fully functional CRUD (Create, Read, Update Status).
*   **Profiles:** Parents can view the squad and recruit new "Titans" (Children).
