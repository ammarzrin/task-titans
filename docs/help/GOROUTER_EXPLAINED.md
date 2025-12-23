# GoRouter Explained: Navigation for Task Titans

GoRouter is our declarative routing package for Flutter, enabling robust and flexible navigation within the Task Titans app. It's particularly well-suited for handling complex navigation patterns like authentication redirects and persistent bottom navigation bars.

## Why GoRouter?
*   **Declarative:** Define your routes once, and GoRouter handles the navigation logic.
*   **Deep Linking:** Supports deep linking out-of-the-box.
*   **Authentication Guards:** Easily implement logic to redirect users based on their authentication status.
*   **Complex UI Patterns:** Simplifies implementing patterns like nested navigation and persistent UI elements.

## Key Concepts to Master:

### 1. Routes & Sub-routes
*   You define a tree of routes that correspond to different screens or sections of your app.
*   **Example:** `/login`, `/parent/dashboard`, `/child/hq`.
*   Sub-routes allow you to define paths that are nested within others (e.g., `/family/mission/:id` where `:id` is a parameter).

### 2. `redirect`
*   The `redirect` property (or `redirect` function) is crucial for controlling navigation flow based on application state.
*   In Task Titans, we'll use it to:
    *   **Auth Guard:** Redirect unauthenticated users to the `/login` screen if they try to access a protected route.
    *   Redirect authenticated users away from the `/login` screen if they're already signed in.

### 3. `ShellRoute` (or `StatefulShellRoute`)
*   This is a powerful feature for UIs with persistent navigation elements, such as a bottom navigation bar.
*   A `ShellRoute` ensures that a specific widget (like our bottom navigation bar) remains on screen while its "shell" content (the different pages accessed via the tabs) changes.
*   This prevents the navigation bar from rebuilding or losing its state when switching between tabs. For Task Titans, it will keep our hero's bottom nav consistent while navigating between HQ, My Missions, and Loot Store.

### 4. Parameters
*   GoRouter allows you to pass data between routes using path parameters.
*   **Example:** In a route like `/mission/:id`, `:id` is a parameter. You can extract this `id` in the destination widget to fetch details for a specific mission.

## GoRouter in Task Titans
In Task Titans, GoRouter will be used to:
*   Manage the overall navigation flow, including authentication-based redirection.
*   Implement the persistent bottom navigation bar for the Child Dashboard.
*   Handle navigation to specific missions or rewards using route parameters.