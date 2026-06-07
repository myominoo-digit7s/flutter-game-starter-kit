# Routing

The app uses `go_router` for navigation.

## Setup
- **AppRoutes**: Defines constant string paths for each route (e.g., `/game`, `/settings`).
- **AppRouter**: The `GoRouter` instance configuring what Flutter widget to build for each route.

## Adding a new route
1. Add the path constant to `AppRoutes` in `lib/app/router/app_routes.dart`.
2. Add a `GoRoute` entry to the `routes` list in `lib/app/router/app_router.dart`.
3. Use `context.push(AppRoutes.yourNewRoute)` to navigate to it.
