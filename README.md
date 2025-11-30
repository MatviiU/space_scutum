# Space Scutum - Task Manager & Weather App

A clean, modern Flutter application for managing daily tasks and tracking current weather
conditions. Built with a focus on Clean Architecture, Scalability, and User Experience.

## 🚀 Features

- **Task Management**: Create, delete, and complete tasks.
- **Filtering**: Filter tasks by status (Active/Completed) and Category (Work, Personal, etc.).
- **Smart UI**: Dynamic interface that adapts to empty states (Contextual Actions).
- **Offline First**: All tasks are persisted locally using SQLite (Drift).
- **Live Weather**: Real-time weather updates based on user location(in future) (OpenWeatherMap API).

## 🛠 Tech Stack & Architecture

The project follows **Clean Architecture** principles to ensure separation of concerns and
testability.

- **State Management**: `flutter_bloc` (Cubits) for predictable state transitions.
- **Dependency Injection**: `get_it` + `injectable` for robust and scalable module management.
- **Navigation**: `go_router` for declarative routing and deep linking support.
- **Local Database**: `drift` (SQLite) for type-safe database operations and reactivity.
- **Code Generation**: `build_runner`, `json_serializable`.

### 🌐 Networking Decision: Dio + Retrofit

For network operations (Weather Feature), **Dio** combined with **Retrofit** was chosen over the
standard `http` client.

**Justification:**

1. **Interceptors**: Dio allows global configuration of Interceptors. This is crucial for injecting
   the API Key into every request automatically, logging errors, and handling timeouts centrally
   without code duplication.
2. **Type Safety & Productivity**: Retrofit generates all the boilerplate code for API calls.
   Instead of manually parsing JSON and constructing URLs strings, we define an interface with
   annotations (`@GET`, `@Query`), ensuring type safety and reducing human error.
3. **Error Handling**: Dio provides structured `DioException` types (timeout, response, cancel),
   making error handling in the Data Layer much more precise than standard HTTP status codes.

## ⚙️ Setup & Run

1. **Clone the repository.**
2. **Setup Environment Variables:**
   Create a `.env` file in the root directory and add your OpenWeatherMap key:
   ```
   OPEN_WEATHER_KEY=your_api_key_here
   ```
3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
4. **Generate Code:**
   (Required for DI, Drift, and Retrofit)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. **Run the App:**
   ```bash
   flutter run
   ```

## 📍 Note on Location Service

For the scope of this test assignment, the **Location Service** is currently mocked to return a
fixed location (Kyiv).
This decision was made to focus on the architectural implementation of the Weather feature without
the overhead of configuring native permissions (iOS Info.plist / AndroidManifest) for every review
environment.
The architecture allows swapping the `LocationService` implementation with `geolocator` in one line
of code.