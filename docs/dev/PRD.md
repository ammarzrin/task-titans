# Product Requirements Document (PRD) - Task Titans

**Version:** 1.0  
**Status:** Ready for Implementation  
**Last Updated:** December 18, 2025

---

## 1. Executive Summary

**Task Titans** is a gamified chore management application for families, designed to transform mundane household tasks into an exciting superhero adventure. By combining a bold "Comic Book" aesthetic with RPG mechanics, the app motivates children (ages 5-12) to complete chores ("Missions") to earn Gold and Experience Points (XP), unlocking real-world rewards and leveling up their "Hero Rank."

The system utilizes a **Flutter** frontend for a high-performance cross-platform experience and **Supabase** for a secure, scalable backend-as-a-service.

---

## 2. Product Goals & Success Metrics

### 2.1 Goals
*   **Gamification:** Turn chore completion into a positive, rewarding loop using instant gratification (Gold/XP) and visual feedback.
*   **Family Autonomy:** Allow parents to define custom tasks and rewards suitable for their household values.
*   **Simplicity:** Provide a "Netflix-style" profile switching experience to manage multiple children on a single shared family device or individual devices.
*   **Visual Appeal:** Deliver a unique "Power Pop" design language that feels like a playable comic book.

### 2.2 Success Metrics (MVP)
*   Successful completion of the "Core Loop": Parent creates Mission -> Child claims & completes Mission -> Parent approves -> Child receives rewards.
*   Reliable synchronization of data across devices using Supabase.
*   Secure isolation of family data via Row Level Security (RLS).

---

## 3. User Roles & Personas

### 3.1 The Admin (Parent)
*   **Responsibilities:** Creates the Family account, manages child profiles, sets up Missions, defines Rewards, and approves completed work.
*   **Needs:** Quick task entry, clear visibility of what needs approval, and control over the "economy" (Gold values).

### 3.2 The Hero (Child)
*   **Responsibilities:** Browses the "Mission Board", claims tasks, marks them as done, tracks their Hero Stats (XP/Gold), and redeems Gold for Rewards.
*   **Needs:** Fun, big buttons, immediate visual feedback (animations), and a clear sense of progression.

---

## 4. Functional Requirements

### 4.1 Authentication & Onboarding
*   **Family Account:** Users sign up/login via Email & Password (Supabase Auth). This creates a `family_id`.
*   **Profile Switching:**
    *   Upon login, the user is presented with a grid of Family Profiles.
    *   Access to any profile requires a 4-digit **PIN**.
    *   **Security:** RLS policies ensure users can only see profiles linked to their `family_id`.

### 4.2 Profile Management
*   **Structure:** Each family has multiple profiles (`parent` or `child` roles).
*   **Attributes:** Username, Role, PIN, Avatar (SVG Asset ID).
*   **Stats (Children Only):** XP (Experience), Gold (Currency), Level (Derived from XP).

### 4.3 Mission Control (Chores)
*   **Creation (Parent):**
    *   Inputs: Title, Icon, Difficulty (Easy/Medium/Hard/Epic), Assignee (Optional).
    *   **Logic:** Difficulty selection automatically populates XP and Gold values based on a predefined scaling matrix.
*   **Discovery (Child):**
    *   "Mission Board" shows available tasks (General Pool + Assigned to Child).
    *   **Claiming:** A child must "Claim" a task to move it to "My Missions" and prevent others from doing it.
*   **Completion Flow:**
    *   Child marks Mission as "Done".
    *   Status changes to `pending_approval`.
    *   Parent reviews and clicks "Approve" (Granting rewards) or "Reject" (Resetting status).

### 4.4 The Economy (Shop & Inventory)
*   **Reward Creation (Parent):** Parents define custom rewards (e.g., "Ice Cream", "Screen Time") and set a Gold price.
*   **Redemption (Child):**
    *   Child views "Loot Store".
    *   Purchase action triggers a transactional database function (RPC).
    *   **RPC Logic:** Verify funds -> Deduct Gold -> Create Inventory Item.
*   **Fulfillment:** Child shows "Inventory" item to Parent -> Parent marks item as `archived` (Fulfilled).

### 4.5 Gamification Mechanics
*   **Leveling:** XP is cumulative. Levels are calculated thresholds (e.g., Level 2 = 500 XP).
*   **Visuals:** Progress bars for XP, counters for Gold.

---

## 5. Technical Architecture

### 5.1 Tech Stack
*   **Frontend:** Flutter (Mobile, targeting iOS/Android).
*   **Language:** Dart.
*   **State Management:** Riverpod (using `Notifiers` and `AsyncValue`).
*   **Navigation:** GoRouter.
*   **Backend:** Supabase (PostgreSQL, Auth, Edge Functions/RPC).

### 5.2 Database Schema (Supabase)
*   **`profiles`**: User data, stats, roles.
*   **`families`**: Grouping entity.
*   **`missions`**: Tasks with status workflow.
*   **`rewards`**: Shop items.
*   **`inventory`**: Purchased items.

### 5.3 Security
*   **Authentication:** Supabase Auth handles the session.
*   **Authorization:**
    *   **RLS (Row Level Security):** Strict policies on all tables enforcing `family_id = auth.uid()`.
    *   **App Logic:** UI restricts features based on the active Profile's `role`.

---

## 6. Design System Requirements

*   **Aesthetic:** "Power Pop" (Comic Book Style).
*   **Typography:**
    *   Headings: **Bungee** (Google Font).
    *   Body: **Nunito** (Google Font).
*   **Colors:**
    *   Primary: Electric Blue (`#0056FF`), Vigilante Red (`#FF1D25`).
    *   Currency: Lightning Yellow (`#FFD700`).
    *   Outlines: Comic Black (`#000000`).
*   **UI Components:**
    *   **Hard Shadows:** Non-blurred, offset black shadows for a 3D pop effect.
    *   **Thick Borders:** 2px-3px solid black borders on all interactive elements.

---

## 7. Implementation Phases

### Phase 1: Foundation (Current Focus)
*   Project Setup (Flutter + Riverpod + Supabase).
*   Design System Implementation (Theme, Fonts, Custom Widgets).
*   Supabase Setup (Tables, RLS, Mock Data).

### Phase 2: Core Loop
*   Auth & Profile Switching Screens.
*   Parent Dashboard (Mission CRUD).
*   Child Dashboard (View & Claim).

### Phase 3: The Economy & Polish
*   Reward Shop & Inventory.
*   Approval Workflow.
*   Gamification Visuals (Animations, Progress Bars).
*   Final QA & Testing.

---

## 8. Assumptions & Constraints
*   **Device:** Initial design targets Mobile Portrait mode.
*   **Connectivity:** App requires internet connection (offline mode is out of scope for MVP).
*   **Backend:** No custom server; 100% reliance on Supabase native features.
