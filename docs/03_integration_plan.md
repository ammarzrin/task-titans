# 03. Integration Plan: Supabase & Flutter Integration

This document outlines the finalized integration strategy for connecting the Flutter frontend to the Supabase backend using Riverpod.

## 1. Client Setup & Architecture

*   **Supabase Client Access:**
    *   The `SupabaseClient` will be exposed via a global Riverpod provider: `final supabaseProvider = Provider((ref) => Supabase.instance.client);`.
    *   This ensures easy dependency injection and testability.

*   **Repository Pattern:**
    *   We will **NOT** call Supabase directly from the UI.
    *   We will implement a **Repository Layer** to encapsulate data access logic.
    *   **Planned Repositories:**
        *   `AuthRepository`: Handles Login, Sign Up, and PIN verification.
        *   `ProfileRepository`: Fetches and updates user profiles (Switching current user).
        *   `MissionRepository`: Handles CRUD for missions and approvals.
        *   `RewardRepository`: Handles Shop items and Redemptions (via RPC).

## 2. Data Flow & State Management

*   **State Management:** Riverpod (`ConsumerWidget`, `StateNotifier` / `AsyncNotifier`).
*   **Data Sync Strategy:** **"Invalidate on Mutation"**.
    *   Providers will be used to fetch data (e.g., `activeMissionsProvider`).
    *   When a mutation occurs (e.g., `addMission`), the corresponding list provider will be **invalidated** (`ref.invalidate(...)`).
    *   This forces Riverpod to re-fetch the freshest data automatically, keeping the UI in sync without complex manual updates.

## 3. Data Modeling & Type Safety

*   **Models:** Strict Dart models will be created for all database tables (`Profile`, `Mission`, `Reward`).
*   **Serialization:** We will use **`json_serializable`** (or `freezed`) to robustly handle the conversion between Supabase JSON responses and Dart objects.
*   **Consistency:** Model properties must match Database column names exactly to ensure smooth serialization.

## 4. Error Handling

*   **Strategy:**
    *   The Repository layer is responsible for catching **Supabase-specific errors** (e.g., `PostgrestException`, `AuthException`).
    *   These low-level errors will be caught and re-thrown as custom, user-friendly **AppExceptions** (e.g., `NetworkException`, `PermissionException`).
    *   The UI layer (Notifiers) will catch these `AppExceptions` and display appropriate Snackbars or Error Widgets.

## 5. Security & Configuration

*   **Environment Variables:**
    *   `SUPABASE_URL` and `SUPABASE_ANON_KEY` will be managed using **`flutter_dotenv`** (for development convenience) or **`--dart-define`** (for production security).
    *   Keys will NOT be hardcoded in the source code.

## 6. Testing Strategy

*   **Unit Tests:** Repositories can be unit tested by mocking the `SupabaseClient`.
*   **Widget Tests:** UI components can be tested by overriding the Riverpod repositories with mock implementations (e.g., `missionRepositoryProvider.overrideWith((ref) => MockMissionRepository())`).
