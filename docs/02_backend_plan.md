# 02. Backend Plan: Backend Design Phase

This document outlines key questions and considerations for the Backend Design Phase of the Task Titans application. Addressing these points will define the core logic, data structures, and API architecture for the Express.js backend.

## 1. Database Choice and Schema

*   **Database Decision:** Given the choices (MySQL, Supabase, Firebase), which database system is most suitable for Task Titans?
    *   **MySQL:** Pros (relational, mature, good for complex queries) / Cons (self-managed, schema changes can be more rigid).
    *   **Supabase:** Pros (PostgreSQL-based, real-time, authentication, storage, functions built-in, similar to Firebase but open source) / Cons (vendor lock-in to some extent, less mature than Firebase).
    *   **Firebase:** Pros (NoSQL, real-time, scalable, easy to integrate with Flutter, rich ecosystem: Auth, Storage, Functions) / Cons (NoSQL might be less intuitive for relational data, cost can scale rapidly).
*   **Core Tables/Collections (High-Level Schema):**
    *   **Users:** What fields are needed (e.g., `id`, `email`, `password_hash`, `role` (parent/child), `family_id`, `created_at`, `updated_at`)?
    *   **Families:** What fields are needed (e.g., `id`, `name`, `family_code`, `created_at`)?
    *   **Quests:** What fields are needed (e.g., `id`, `family_id`, `assigned_to` (child_id or null for pool), `title`, `description`, `xp_reward`, `gold_reward`, `due_date`, `status` (pending, claimed, complete, approved, rejected), `recurrence_pattern`, `created_by`, `created_at`, `updated_at`)?
    *   **Rewards:** What fields are needed (e.g., `id`, `family_id`, `name`, `description`, `gold_cost`, `stock`, `multi_redeemable`, `valid_until`, `created_by`, `created_at`, `updated_at`)?
    *   **Transactions/Redemptions:** What fields are needed (e.g., `id`, `child_id`, `reward_id`, `gold_amount`, `status` (pending, approved, rejected), `redeemed_at`, `approved_by`, `approved_at`)?
*   **Relationships:** How will the tables/collections be related (e.g., One-to-many: Family has many Users, Family has many Quests, User has many Quests)?

## 2. Authentication and Authorization

*   **User Roles:** How will parent (admin) and child (hero) roles be differentiated and enforced?
*   **Authentication Mechanism:**
    *   How will users sign up and log in? (Email/Password, Social logins?).
    *   Will children have separate login credentials or access via a parent's account?
    *   What security measures will be in place for password hashing and token management (e.g., JWT)?
*   **Authorization:**
    *   How will we control access to resources based on user roles (e.g., only parents can create quests, only children can claim their assigned quests)?
    *   How will we ensure users can only access data belonging to their family?

## 3. Quest (Chore) Lifecycle Logic

*   **Quest Creation:**
    *   Backend validation for quest data (rewards, due dates, assignments).
    *   Logic for handling one-time vs. recurring quests. If recurring, how will new instances be generated?
*   **Quest Assignment/Claiming:**
    *   Logic for assigning quests to specific children vs. a general pool.
    *   Handling simultaneous claims if quests are pool-based.
*   **Proof of Completion:**
    *   How will different proof mechanisms (honor system, photo/video upload, text description) be stored and associated with quests?
    *   Logic for child marking quest as "done" and parent marking as "approved" or "rejected."
*   **XP/Gold Calculation:**
    *   Logic for awarding XP and Gold upon parent approval.
    *   Handling deduction/reversal of XP/Gold if a quest is rejected.

## 4. Rewards and Redemption Shop Logic

*   **Reward Management:**
    *   Backend logic for creating, updating, and deleting custom rewards by parents.
    *   Validation for reward costs and stock.
*   **Redemption Flow:**
    *   Logic for a child attempting to redeem a reward (checking gold balance, stock).
    *   Parent approval workflow for redemptions (notification, approval/rejection logic, gold deduction/reversal).
    *   Handling of multi-redeemable vs. limited-stock rewards.
    *   Logic for validity periods of rewards.

## 5. Gamification Logic

*   **XP to Level Conversion:**
    *   What is the formula or table for converting accumulated XP into a child's level?
    *   Are there specific milestones for levels?
*   **Leaderboard:**
    *   How will the family leaderboard be calculated and ordered (e.g., by total XP)?
    *   What data needs to be aggregated for this?
*   **Future Gamification (Placeholder):**
    *   Considerations for badges, streaks, or other elements. How would their logic be implemented in the backend?

## 6. API Server Design (Express.js)

*   **RESTful Principles:** Adherence to RESTful API design principles.
*   **Key Endpoints (Examples and detailed considerations):**
    *   `POST /api/auth/register` (Parent registration)
    *   `POST /api/auth/login`
    *   `POST /api/families` (Create family)
    *   `POST /api/families/{familyId}/children` (Create child profile)
    *   `GET /api/families/{familyId}/users` (Get all users in family, including children)
    *   `POST /api/families/{familyId}/quests` (Create quest)
    *   `GET /api/families/{familyId}/quests` (Get all quests for family)
    *   `GET /api/users/{userId}/quests` (Get quests for a specific child)
    *   `PUT /api/quests/{questId}/claim` (Child claims quest)
    *   `PUT /api/quests/{questId}/complete` (Child marks quest as complete, with proof)
    *   `PUT /api/quests/{questId}/approve` (Parent approves/rejects quest)
    *   `POST /api/families/{familyId}/rewards` (Create custom reward)
    *   `GET /api/families/{familyId}/rewards` (Get all rewards for family)
    *   `POST /api/users/{childId}/rewards/redeem` (Child redeems reward)
    *   `GET /api/families/{familyId}/leaderboard`
*   **Input Validation:** Robust server-side validation for all incoming data.
*   **Error Handling:** Consistent API error responses (e.g., status codes, error messages).
*   **Security:** How will sensitive data be protected (e.g., user passwords, API keys)?
*   **Scalability:** Initial considerations for backend scalability as the user base grows.
