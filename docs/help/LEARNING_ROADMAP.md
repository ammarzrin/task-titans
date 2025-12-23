# Learning Roadmap for Task Titans

This document outlines the essential skills and knowledge required to build **Task Titans**. Since we chose a specific tech stack (Supabase, Riverpod, GoRouter), focusing on these specific areas will save you time compared to learning "generic" Flutter.

---

## 1. State Management: Riverpod

**Why:** We chose Riverpod over Provider/GetX because it handles asynchronous data (like fetching missions from a database) much more safely and easily. It catches errors at compile-time and separates your business logic from the UI.

### **Key Concepts to Master:**

* **Providers vs. Notifiers:** Understanding the difference between a simple `Provider` (read-only value) and a `NotifierProvider` (state that changes).
* **`ref.watch` vs `ref.read`:** When to listen for changes (UI) vs. when to fetch data once (Functions).
* **`AsyncValue`:** This is crucial. It handles `loading`, `error`, and `data` states automatically. You will use this everywhere for Supabase data.
* **`ref.invalidate`:** Our strategy for "Invalidate on Mutation" (refreshing data after an update).

### **Recommended Resources:**

* **Official Docs:** [Riverpod.dev](https://riverpod.dev/) (Read the "Essentials" section first).
* **Video:** [Riverpod 2.0 - The Ultimate Guide](https://www.youtube.com/watch?v=BJtQ0dfI-RA) (by Code with Andrea - highly recommended).
* **Article:** [Flutter Riverpod: The Essential Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

---

## 2. Backend & Database: Supabase

**Why:** Supabase replaces the need for a separate backend server. You need to understand how to structure data and secure it.

### **Key Concepts to Master:**

* **Relational Database (SQL):** Basic understanding of Tables, Primary Keys (UUID), and Foreign Keys (linking a Mission to a Family).
* **Authentication:** How Supabase Auth works (Sign Up, Sign In, User Sessions).
* **Row Level Security (RLS):** **CRITICAL.** This is how you secure data. You must learn how to write policies like "Users can only see rows where `family_id` matches their own."
* **Postgres Functions (RPC):** We decided to use these for complex logic (like `purchase_reward`). Learn how to write a simple PL/pgSQL function in the Supabase Dashboard.

### **Recommended Resources:**

* **Official Flutter Guide:** [Supabase Flutter Quickstart](https://supabase.com/docs/guides/getting-started/quickstarts/flutter)
* **Video:** [Flutter & Supabase Crash Course](https://www.youtube.com/watch?v=Nn7D4yD1t68) (covers Auth and Database).
* **Docs (RLS):** [Supabase Row Level Security Guide](https://supabase.com/docs/guides/database/postgres/row-level-security)
* **Docs (Functions):** [Database Functions](https://supabase.com/docs/guides/database/functions)

---

## 3. Navigation: GoRouter

**Why:** Task Titans has complex navigation needs: Authentication redirection (Redirect to Login if not authenticated) and Bottom Navigation Tabs (Dashboard/Shop/Profile).

### **Key Concepts to Master:**

* **Routes & Sub-routes:** Defining the URL path structure (e.g., `/family/mission/:id`).
* **`redirect`:** Writing the logic to guard routes (Auth Guard).
* **`ShellRoute` (or `StatefulShellRoute`):** This is the magic widget that keeps your Bottom Navigation Bar persistent while changing the page content above it.
* **Parameters:** Passing data (like `missionId`) via the URL.

### **Recommended Resources:**

* **Official Docs:** [pub.dev/packages/go_router](https://pub.dev/packages/go_router)
* **Article:** [Flutter Navigation with GoRouter: The Complete Guide](https://codewithandrea.com/articles/flutter-navigation-gorouter/) (Focus on the "ShellRoute" section).

---

## 4. Flutter UI: The "Comic Book" Design

**Why:** We are implementing a custom design system ("Power Pop") that relies on specific styling techniques.

### **Key Concepts to Master:**

* **`BoxDecoration`:** You will use this *constantly* to create the specific look:
  * `border: Border.all(width: 2, color: Colors.black)`
  * `boxShadow`: Creating "Hard Shadows" (Offset 4,4 with 0 Blur).
  * `borderRadius`: consistent rounding.
* **`ThemeData`:** How to set the default font to `Nunito` and `Bungee` globally so you don't have to specify it on every text widget.
* **`SVG` Assets:** Using `flutter_svg` package to render your sticker-style icons.

### **Recommended Resources:**

* **Docs:** [Flutter Container & BoxDecoration](https://api.flutter.dev/flutter/widgets/Container-class.html)
* **Video:** [Flutter Theming: 3 Ways to Theme Your App](https://www.youtube.com/watch?v=oHWqFjRk2iM)

---

## 5. Data Modeling: JSON Serialization

**Why:** When Supabase sends data, it arrives as a `Map<String, dynamic>` (JSON). You need to convert this safely into Dart classes (`Mission`, `Profile`).

### **Key Concepts to Master:**

* **`json_serializable`:** A package that writes the `fromJson` and `toJson` code for you.
* **OR `freezed`:** A more advanced package that adds "Pattern Matching" and "Immutability." (Recommended for Riverpod users).

### **Recommended Resources:**

* **Article:** [Data classes in Flutter with Freezed](https://codewithandrea.com/articles/flutter-data-models-freezed/)

---

## Summary Checklist

Before starting implementation, try to tick these off:

- [ ] Created a Supabase project and tried creating one table.
- [ ] Built a simple Flutter "Counter App" using Riverpod.
- [ ] Read about how `ShellRoute` works in GoRouter.
- [ ] Experimented with creating a "Hard Shadow" button in Flutter.
