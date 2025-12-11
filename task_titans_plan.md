# Task Titans Project Plan

## 1. Project Overview

*   **Project Name:** Task Titans
*   **Goal/Vision:** A family chore management app that gamifies household management by transforming chores into engaging quests for children to feel like heroes, earn XP and virtual Gold, and redeem custom rewards. Aims to replace household friction with a fun, rewarding, and collaborative experience.
*   **Target Audience:** Families with children
*   **Core Features (Summarized):**
    *   Admin Dashboard (Parents): Create/manage quests, assign XP/Gold, set due dates, verify completion.
    *   Hero Dashboard (Children): Browse/claim quests, mark tasks done, track progress (level, gold).
    *   Custom Redemption Shop: Exchange Gold for real-world rewards defined by parents.
    *   Family Leaderboard: Ranking based on total XP.
*   **Tech Stack:**
    *   Frontend: Flutter
    *   Backend: Express.js (RESTful APIs)
    *   Database: MySQL/Supabase/Firebase (I’m still deciding. Guide me to which one is suitable/preferred for my project.)

---

## 2. User Roles & Family Setup

*   **Family Creation Flow:**
    *   A Parent signs up, creates a Family, another parent can join via Family ID, then whichever parent can create new Children/Hero profiles for their children.
    *   Parents (Admins) in a Family (Group) has administrative privileges to create new children profiles, create new tasks available, create their own customised rewards, and approve their children's completed tasks.

*   **Child Account Access:**
    *   Will children have their own login credentials (email/password, username/password)?
    *   Or will they access their dashboard through a parent's logged-in account (e.g., parent logs in, then switches to a child's profile)?

*   **Age-Specific UI/Features:**
    *   Do you envision different levels of UI complexity or feature access based on a child's age? (e.g., simpler interface for younger kids, more options for older ones).

---

## 3. Quest (Chore) Lifecycle

*   **Quest Types:**
    *   Will quests only be one-time tasks?
    *   Or will you support recurring chores (e.g., daily, weekly, monthly)? If recurring, how should completion be tracked (e.g., separate completion for each recurrence)?

*   **Quest Assignment:**
    *   Can parents assign quests directly to a specific child (e.g., "Johnny, clean your room")?
    *   Or are all quests created by parents available in a general "Available Quests" pool for any child to claim?
    *   Can quests be claimed by multiple children (e.g., "Everyone help with dinner prep")?

*   **Proof of Completion Mechanism:**
    *   What does "proof of completion" entail?
    *   Simple honor system (child marks done, parent approves)?
    *   Require photo/video upload from child?
    *   Require a quick text description from child?

---

## 4. Rewards & Redemption Shop

*   **Reward Redemption Flow:**
    *   When a child redeems an item, is it automatically marked as "claimed" and deducted from their gold?
    *   Or does the parent receive a notification for approval before the gold is deducted and the reward is considered "redeemed"?
    *   What happens if a parent rejects a redemption (e.g., child didn't earn it fairly, reward isn't available)?

*   **Reward Stock/Availability:**
    *   Can a reward be claimed multiple times (e.g., "1 Hour of TV")?
    *   Or should rewards have a limited stock that decreases upon redemption (e.g., "One trip to the ice cream shop")?
    *   Can rewards have a validity period?

---

## 5. Gamification Elements

*   **Beyond XP/Gold/Leaderboard:**
    *   Are there other gamification elements you'd like to include (e.g., badges for milestones, streaks for consistent chore completion, special events)?
    *   How does the XP system translate to levels? Is it purely cosmetic, or do new levels unlock features/avatars/etc.?

---

## 6. Minimum Viable Product (MVP) Scope

*   **Absolute Must-Have Features for Initial Launch (for a one-month timeline):**
    *   List the core features that *must* be in the app for its first usable version.

*   **Features to Postpone (Nice-to-haves for future iterations):**
    *   List features that would be great but can wait until after the initial launch to manage the one-month scope.

---

## 7. Technical Details (High-Level Planning)

*   **Database Schema (Key Tables & Relations):**
    *   Propose the main tables you envision (e.g., `Users`, `Families`, `Quests`, `Rewards`, `Transactions`).
    *   Outline the primary relationships between these tables. (No need for detailed columns yet, just the entities and their connections).

*   **Key API Endpoints (Examples):**
    *   List a few essential API endpoints for parent and child actions (e.g., `POST /api/quests`, `GET /api/users/{id}/quests`, `POST /api/rewards/redeem`).

*   **Flutter Frontend State Management:**
    *   Which state management solution are you planning to use for Flutter (e.g., Provider, Riverpod, BLoC, GetX, Vanilla StatefulWidget)?

---
Feel free to fill this out at your leisure. Once you're ready, just let me know, and we can proceed with planning based on this detailed information!