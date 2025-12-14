# Task Titans - Gamified Family App

## 1. Project Overview

- **Project Name:** Task Titans
- **Goal/Vision:** A family chore management app that gamifies household management by transforming chores into engaging **superhero missions**. Children feel like heroes, earn XP and virtual Gold, and redeem custom rewards. Aims to replace household friction with a fun, rewarding, and collaborative experience.
- **Target Audience:** Families with children aged 5-12
- **Core Features (Summarized):**
  - **Admin Dashboard (Mission Control):** Parents create/manage missions (quests) using difficulty presets, set due dates, verify task completion, and manage the reward shop.
  - **Hero Dashboard (Hero HQ):** Children view/claim missions, mark tasks as done, earn XP and gold, track their **Hero Rank**, and redeem rewards.
  - **Custom Redemption Shop (Loot Store):** Exchange Gold for real-world rewards.
  - **Family Leaderboard:** Ranking based on total XP (Planned for future).
- **Tech Stack:**
  - Frontend: Flutter (Riverpod, GoRouter)
  - Backend: Supabase (BaaS) - Auth, Database, Edge Functions
  - Database: Supabase (PostgreSQL)

---

## 2. User Roles & Family Setup

- **Family Creation Flow:**

  - Parent signs up, creates a Family (Squad). Another parent can join via Family ID.
  - Parents (Admins) manage the Squad, create profiles, missions, and rewards.

- **Account Access & Security:**

  - **PIN Code System:** ALL profiles (Parents and Children) are protected by a 4-digit PIN.

- **UI/UX Strategy:**
  - **Aesthetic:** **Comic Book / Superhero Pop**. Bold colors ("Power Pop" palette), thick outlines, halftone patterns, and "sticker" style icons.
  - **Typography:**
    - **Headings:** `Bungee` (Bold, geometric, urban/comic feel).
    - **Body:** `Nunito` (Rounded, friendly).
  - **Standardized UI:** Simple, punchy, icon-heavy interface for all ages.

---

## 3. Mission (Quest) Lifecycle

- **Mission Creation:**

  - Parents create missions using **Difficulty Presets** (Easy, Medium, Hard, Epic) which auto-set XP/Gold.
  - Parents select a **Superhero-themed Icon** for the mission.

- **Assignment:**

  - **General Pool (Default):** Missions available for any Hero to claim.
  - **Specific Assignment:** Optional direct assignment.
  - **"Claim First":** Heroes must accept a mission from the board to move it to their "My Missions" list.

- **Proof of Completion:**
  - Hero marks mission as done (optional text note).
  - Parent approves/rejects in "Pending Approvals".

---

## 4. Rewards & Redemption Shop

- **Redemption Flow:**

  - **Instant Redemption:** Hero buys item -> Gold deducted -> Item moves to **"Loot Bag"** (Inventory).
  - **Fulfillment:** Hero shows Loot Bag to parent -> Parent archives item.

- **Stock:**
  - Rewards can have Limited or Unlimited stock.

---

## 5. Gamification Elements

- **Visuals:**
  - **Hero ID Card:** Top of dashboard shows Avatar, **Hero Rank** (Level), **XP Energy Bar**, and Gold Stash.
  - **Feedback:** "POW!" style comic bursts for completion and leveling up.

---

## 6. Minimum Viable Product (MVP) Scope

- **Absolute Must-Have Features for Initial Launch:**

  - **Shared:** Login, Family Setup, PIN Entry.
  - **Parent (Mission Control):**
    - Manage Squad (Family/Profiles).
    - Manage Missions (Create/Edit/Delete with Presets).
    - Manage Rewards (Loot Store).
    - Approve Missions.
    - Archive Redeemed Loot.
  - **Child (Hero HQ):**
    - Dashboard with Hero Stats & Mission Board.
    - Claim & Complete Missions.
    - Buy Rewards & View Loot Bag.

- **Features to Postpone:**
  - Advanced Leaderboards.
  - Achievements/Badges.
  - Manual XP/Gold adjustment.

---

## 7. Technical Details (High-Level Planning)

- **Database Schema (Key Tables & Relations):**
  - `profiles` (Users/Heroes)
  - `families` (Squads)
  - `missions` (Quests)
  - `rewards` (Loot)
  - `inventory` (Transactions/Bag)

- **Communication:** Native DB Communication via Supabase Flutter SDK (Repository Pattern)
- **State Management:** Riverpod
- **Navigation:** GoRouter
