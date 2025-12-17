# 02. Backend Plan: Backend Design Phase

This document outlines the finalized decisions for the Backend Design Phase of the Task Titans application, utilizing **Supabase** as the Backend-as-a-Service (BaaS).

## 1. Database & Architecture

*   **Database:** **Supabase** (PostgreSQL).
*   **Architecture:** **Supabase Native**.
    *   The app will **NOT** use a separate Express.js server.
    *   Flutter will communicate directly with the database using the `supabase_flutter` package.
    *   Security is handled via PostgreSQL **Row Level Security (RLS)** policies.

## 2. Database Schema

The schema relies on relational integrity.

### Tables

1.  **`profiles`** (Users)
    *   `id` (UUID, PK): Linked to Supabase Auth User ID (for parents) or generated (for children).
    *   `family_id` (UUID, FK): Links to `families` table.
    *   `role` (Text/Enum): `'parent'` or `'child'`.
    *   `username` (Text): Display name.
    *   `avatar_id` (Text): ID of selected SVG avatar.
    *   `pin_code` (Text): 4-digit PIN for profile switching.
    *   `xp` (Int, Nullable): Current XP (NULL for parents).
    *   `gold` (Int, Nullable): Current Gold (NULL for parents).
    *   `level` (Int, Nullable): Calculated level (NULL for parents).

2.  **`families`** (Groups)
    *   `id` (UUID, PK).
    *   `name` (Text): Family name (e.g., "The Smiths").
    *   `invite_code` (Text): Unique code for adding other parents.

3.  **`missions`** (Chores/Quests)
    *   `id` (UUID, PK).
    *   `family_id` (UUID, FK).
    *   `title` (Text).
    *   `difficulty` (Text/Enum): `'easy'`, `'medium'`, `'hard'`, `'epic'`.
    *   `icon_id` (Text).
    *   `assigned_to` (UUID, Nullable, FK): Linked to `profiles`. If NULL, it is in the "General Pool".
    *   `status` (Text/Enum): `'available'`, `'in_progress'`, `'pending_approval'`, `'completed'`.
    *   `xp_reward` (Int).
    *   `gold_reward` (Int).
    *   `created_by` (UUID, FK).

4.  **`rewards`** (Shop Items)
    *   `id` (UUID, PK).
    *   `family_id` (UUID, FK).
    *   `title` (Text).
    *   `cost` (Int).
    *   `icon_id` (Text).
    *   `stock` (Int, Nullable): Number available. If NULL, stock is unlimited.

5.  **`inventory`** (Redeemed Items)
    *   `id` (UUID, PK).
    *   `child_id` (UUID, FK).
    *   `reward_id` (UUID, FK).
    *   `status` (Text/Enum): `'active'` (in Loot Bag) or `'archived'` (fulfilled/deleted).
    *   `purchased_at` (Timestamp).

## 3. Authentication & Authorization

*   **Primary Login:**
    *   Uses **Supabase Auth** (Email/Password). This authenticates the device as a "Family Account".
*   **Profile Switching (Netflix Style):**
    *   After the system login, the app fetches all `profiles` for the family.
    *   User selects a profile and enters the 4-digit **PIN**.
    *   The App State (Riverpod) manages the "Current Active Profile".
    *   **Note:** The database connection remains authenticated as the parent/family account, but the App UI restricts access based on the selected profile's PIN.

## 4. Logic & Data Flow

*   **Standard Operations (CRUD):**
    *   Simple actions (Creating a mission, Editing a profile, Creating a reward) are performed via direct Supabase calls from Flutter (e.g., `supabase.from('missions').insert(...)`).
*   **Transactional Logic (RPC Functions):**
    *   Complex actions requiring atomicity will use **Postgres Functions** (RPC) stored on Supabase.
    *   **`purchase_reward`**: Deducts gold from `profiles` AND adds item to `inventory`. Failing one fails both.
    *   **`approve_mission`**: Updates `missions` status AND adds XP/Gold to `profiles`.
*   **Real-time:**
    *   **Disabled for MVP.** The app will use standard data fetching (pull-to-refresh, reload on init) to keep data in sync.

## 5. Security (RLS)

*   **Row Level Security** policies will be enabled on all tables.
*   **Rule:** Users can only `SELECT`, `INSERT`, `UPDATE`, `DELETE` rows where `family_id` matches their own `family_id`. This ensures strict data isolation between different families.
