# Architecture Overview

The app is divided into distinct layers to separate UI, game logic, state management, and services.

## App Layer
The `app` layer contains the application bootstrap, setup, routing (`go_router`), and generic `AppLifecycleObserver`. It connects the `core` setup with the `MaterialApp` widget.

## Core Layer
The `core` folder is the backbone of the app:
- **config**: App-wide configuration constants.
- **game**: The abstractions over `flame` classes that all games will use. `BaseFlameGame` is the parent class for any game implementation.
- **settings**: Manages global application settings using `SettingsCubit`.
- **storage**: Defines a `LocalStorageService` abstraction, backed by a `SharedPreferences` implementation.
- **theme** & **utils**: App theming and helper extensions.

## Feature Layer
The `features` layer holds Flutter widget implementations for various screens. These are normal Flutter components that handle UI routing and generic app overlays. The actual Flame game is injected into the `GameShellScreen`.

## Games Layer
The `games` layer holds the actual `FlameGame` implementations. By separating `games/` from `features/`, it's clear that Flame components live outside traditional Flutter widgets.

## State Separation
Flame maintains its own internal game loop state (`update(dt)`). Global app state (like settings) is handled via `flutter_bloc` (`SettingsCubit`). Game logic does NOT pollute the Bloc. The UI and Flame communicate via `onGameResult` callbacks and Flame's `overlays` system.
