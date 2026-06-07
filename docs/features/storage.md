# Storage

The `core/storage` folder provides a data persistence abstraction.

- **LocalStorageService**: An abstract interface defining common key-value store operations (`setBool`, `setString`, `setInt`, `remove`, `clear`). This allows easy swapping of the underlying technology.
- **SharedPreferencesStorageService**: The current implementation using the `shared_preferences` package.
- **StorageKeys**: A constant class defining all the string keys used to store data, ensuring type safety and avoiding typos.
