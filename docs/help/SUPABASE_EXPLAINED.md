# Supabase Explained: Our Backend for Task Titans

Supabase is our "Backend-as-a-Service" (BaaS) for Task Titans. It provides all the backend functionalities we need without requiring us to write and maintain a separate server. This includes our database, authentication, and custom server-side logic.

## Why Supabase?
*   **Full-fledged Backend:** Offers PostgreSQL database, authentication, real-time subscriptions, and more.
*   **Flutter Integration:** Excellent official `supabase_flutter` package for easy integration.
*   **Cost-Effective:** Free tier for development and scalable for production.
*   **No Separate Server:** We directly interact with Supabase from Flutter, simplifying our architecture.

## Key Concepts to Master:

### 1. Relational Database (PostgreSQL)
*   Supabase uses PostgreSQL, a powerful relational database. Understanding basic SQL concepts is beneficial:
    *   **Tables:** Where our data is stored (e.g., `profiles`, `missions`, `rewards`).
    *   **Primary Keys (PK):** Unique identifiers for each row (e.g., `id` columns, often UUIDs).
    *   **Foreign Keys (FK):** Links between tables (e.g., `family_id` in `profiles` linking to `id` in `families`). This maintains data relationships.

### 2. Authentication (Supabase Auth)
*   Supabase handles user authentication via email/password.
*   It manages user sessions securely.
*   In Task Titans, it authenticates the *family account*. Profile switching (child PINs) will be handled within the app's UI after the family account is authenticated.

### 3. Row Level Security (RLS) - CRITICAL
*   RLS is the cornerstone of our security. It defines policies directly on the database tables that restrict what data users can access or modify.
*   For Task Titans, RLS ensures that:
    *   A user can only see data (`missions`, `rewards`, `profiles`) belonging to their `family_id`.
    *   This prevents unauthorized access to other families' data.
*   You must learn how to write effective RLS policies to secure our application's data.

### 4. Postgres Functions (RPC)
*   For complex, transactional logic that needs to be atomic (either all steps succeed or all fail), we use Postgres Functions (Remote Procedure Calls - RPC).
*   These are SQL functions stored and executed directly on the Supabase database.
*   **Example:** Our `purchase_reward` function will deduct Gold from a child's profile and add the purchased item to their `inventory` in a single, secure transaction.

## Supabase in Task Titans
In Task Titans, Supabase will be used for:
*   Storing all application data (`profiles`, `missions`, `rewards`, `families`, `inventory`).
*   Managing user authentication for family accounts.
*   Securing data access using RLS.
*   Executing critical business logic via RPC functions.