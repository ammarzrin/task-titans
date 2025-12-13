# Task Titans Project Plan

## 1. Project Overview

- **Project Name:** Task Titans
- **Goal/Vision:** A family chore management app that gamifies household management by transforming chores into engaging quests for children to feel like heroes, earn XP and virtual Gold, and redeem custom rewards. Aims to replace household friction with a fun, rewarding, and collaborative experience.
- **Target Audience:** Families with children aged 5-12
- **Core Features (Summarized):**
  - Admin Dashboard (Parents): Create/manage quests (tasks) using difficulty presets, set due dates, verify task completion, create/manage custom rewards.
  - Hero Dashboard (Children): View/claim quests (tasks), mark tasks as done, earn XP and gold for completed tasks based on difficulty, track their progress (level, gold), redeem rewards with collected gold.
  - Custom Redemption Shop: Exchange Gold for real-world rewards defined/customised by parents.
  - Family Leaderboard: Ranking based on total XP (Planned for future, basic MVP implementation if time permits).
- **Tech Stack:**
  - Frontend: Flutter (Riverpod for State Management, GoRouter for Navigation)
  - Backend: Express.js (RESTful APIs)
  - Database: MySQL/Supabase/Firebase (I’m still deciding. Guide me to which one is suitable/preferred for my project.)

---

## 2. User Roles & Family Setup

- **Family Creation Flow:**
  - A Parent signs up, creates a Family. Another parent can join via Family ID.
  - Parents (Admins) have privileges to create children profiles, quests, rewards, and approve completions.

- **Account Access & Security:**
  - **PIN Code System:** ALL profiles (Parents and Children) are protected by a 4-digit PIN to ensure security and privacy when switching users on a shared device.
  - Children access their dashboard by selecting their profile and entering their PIN.

- **UI/UX Strategy:**
  - **Standardized UI:** The interface will be playful, minimalist, and icon-heavy ("Primary & Pastel" theme). It will be standardized for all ages (5-12) rather than having complex age-gating.
  - Differentiation comes from the *content* (difficulty of quests) rather than UI layout changes.

---

## 3. Quest (Chore) Lifecycle

- **Quest Creation:**
  - Parents create quests using **Difficulty Presets** (Easy, Medium, Hard, Epic) which automatically set the XP and Gold rewards.
  - Parents select a visual **Icon** for the quest from a preset grid.

- **Quest Assignment:**
  - **General Pool (Default):** Quests are available for *any* child to claim.
  - **Specific Assignment:** Parents can optionally assign a quest to a specific child.
  - **"Claim First" Logic:** Children must "Claim" a quest from the pool to move it to their "My Quests" list before they can mark it as done.

- **Proof of Completion Mechanism:**
  - Child marks a task as done.
  - Optional: Child can add a simple text note.
  - Parent approves/rejects the task in the "Pending Approvals" section.

---

## 4. Rewards & Redemption Shop

- **Reward Redemption Flow:**
  - **Instant Redemption:** Child taps to buy -> Gold is deducted immediately -> Item moves to Child's **"Inventory"**.
  - **Fulfillment:** Child shows the item in their Inventory to the parent to receive the real-world reward.
  - **Archiving:** Parent removes/archives the item from the child's inventory via the Admin Dashboard once it has been fulfilled.

- **Reward Stock/Availability:**
  - Parents can set rewards to have **Limited Stock** (finite number) or **Unlimited Stock**.

---

## 5. Gamification Elements

- **Visuals:**
  - **Hero Card:** Top of Child Dashboard always shows Avatar, Level, XP Bar, and Current Gold.
  - **Dynamic Progress:** Animated bars and visual rewards (coins/stars) to maximize engagement.

---

## 6. Minimum Viable Product (MVP) Scope

- **Absolute Must-Have Features for Initial Launch (for a one-month timeline):**

  - **Shared Features:**
    - Login/Family Setup.
    - PIN Code Entry for profile switching.

  - **Parent Role:**
    - Create/Manage Family and Child Profiles (Name, Avatar, PIN).
    - **Quest Management:** Create/Edit/Delete quests using Difficulty Presets and Icon selection.
    - **Reward Management:** Create/Edit/Delete rewards with Stock limits.
    - **Approvals:** Approve/Reject pending quest submissions.
    - **Inventory Management:** View child's redeemed rewards and archive them after fulfillment.

  - **Child Role:**
    - **Dashboard:** View Hero Card (Stats) and Available Quests (Grid View).
    - **Questing:** Claim quests from pool, View "My Quests", Mark as Done (with optional note).
    - **Shopping:** View Redemption Shop, Buy rewards (Instant deduction).
    - **Inventory:** View owned rewards to show parent.

- **Features to Postpone (Nice-to-haves for future iterations):**
  - Advanced Leaderboard logic.
  - Achievements/Badges system.
  - Manual adjustment of XP/Gold by parents.

---

## 7. Technical Details (High-Level Planning)

- **Database Schema (Key Tables & Relations):**
  - Users/Parents
  - Children (Child ID, Name, Avatar, PIN, Level, XP, Gold)
  - Quests (Title, Description, Difficulty/Category, Icon, Assignee, Due Date, Status)
  - Rewards (Title, Cost, Stock, Icon, Stock_Limit_Boolean)
  - Inventory/Transactions (Child ID, Reward ID, Status [Active/Archived])

- **Key API Endpoints (Examples):**
  - *To be defined in Backend Plan.*

- **Flutter Frontend State Management:**
  - **Riverpod**
- **Navigation:**
  - **GoRouter**

