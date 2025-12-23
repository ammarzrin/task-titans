# Riverpod Explained: State Management for Task Titans

Riverpod is our chosen state management solution for Task Titans. It's designed to handle asynchronous data and complex application states safely and efficiently, especially when dealing with backend interactions like fetching missions from Supabase.

## Why Riverpod?
*   **Safety:** Catches errors at compile-time, reducing runtime bugs.
*   **Separation of Concerns:** Helps keep your business logic distinct from your UI.
*   **Asynchronous Data:** Excels at managing the `loading`, `error`, and `data` states of data fetched from sources like Supabase.

## Key Concepts to Master:

### 1. Providers vs. Notifiers
*   **`Provider`**: A simple provider that holds a read-only value. Useful for exposing constants or immutable objects.
*   **`NotifierProvider`**: Used for state that can change over time. It exposes a `StateNotifier` or `AsyncNotifier` which can be updated.

### 2. `ref.watch` vs `ref.read`
*   **`ref.watch`**: Used in UI widgets to *listen* for changes to a provider's state. When the state changes, the widget (or part of it) automatically rebuilds.
*   **`ref.read`**: Used to *get* a provider's value once, without listening for future changes. Ideal for triggering actions (e.g., in an `onPressed` callback) or accessing dependencies within other providers.

### 3. `AsyncValue`
*   This is a core concept for handling asynchronous data. `AsyncValue` automatically represents the three possible states of an asynchronous operation:
    *   **`AsyncValue.loading()`**: The data is currently being fetched.
    *   **`AsyncValue.error(error, stackTrace)`**: An error occurred during fetching.
    *   **`AsyncValue.data(value)`**: The data has been successfully fetched.
*   You will use `AsyncValue` extensively to manage the UI state for all data coming from Supabase.

### 4. `ref.invalidate`
*   Our strategy for keeping the UI in sync after data modifications is "Invalidate on Mutation".
*   When you perform an action that changes data in the backend (e.g., adding a mission, completing a task), you will use `ref.invalidate(someProvider)` to tell Riverpod that the data provided by `someProvider` is now stale.
*   Riverpod will then automatically re-fetch the data for that provider, ensuring your UI reflects the latest state from Supabase.

## Riverpod in Task Titans
In Task Titans, Riverpod will be used to:
*   Manage the currently logged-in user and active profile.
*   Fetch and display lists of missions, rewards, and profiles from Supabase.
*   Handle the loading and error states for all data interactions, providing a robust and responsive user experience.