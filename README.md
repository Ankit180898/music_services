# Mini Project – “Music Services Module (Single Screen)”

![music_services](https://github.com/user-attachments/assets/37f3d962-218f-4780-bc9d-95f61cf2b177)

## Project Overview

This Flutter application is an assignment for flutter developer role by S.Rocks.Music. It lists various music platforms with their details and icons, following a clean UI/UX approach.

## Architecture

The project follows a clean architecture pattern with the following structure:

```
lib/
├── model/         # Data models and entities
├── repository/    # Data repositories and business logic
├── services/      # External services (Firebase, APIs)
├── utils/         # Utility functions and helpers
├── view/          # UI screens and pages
├── view_model/    # View models and state management
├── widgets/       # Reusable UI components
└── main.dart      # Application entry point
```

### Key Components

- **Model**: Contains data models for music services.
- **Repository**: Implements business logic for getting the music services list data.
- **Services**: Handles external service integrations i.e Firebase Service for getting music services data list.
- **View**: Contains all UI screens for showing list of music services and details of it.
- **ViewModel**: Manages state and business logic for views
- **Widgets**: Reusable UI components for consistent design

## Dependencies

The project uses several key dependencies:

- **Firebase**: For backend services, authentication, and real-time collaboration
- **Provider**: For state management
- **GetIt**: For dependency injection
- **Flutter**: Latest stable version

## Setup and Installation

1. Clone the repository:
```bash
git clone https://github.com/Ankit180898/music_services.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Add your Firebase configuration files
   - Enable necessary Firebase services (Authentication, Firestore, Storage)

4. Run the application:
```bash
flutter run
```
## Screen Recording


https://github.com/user-attachments/assets/ba2ffcd5-6c20-4772-8de8-00ddfd2e970b


## Development Approach

The project follows these key principles:

1. **Clean Architecture**: Separation of concerns with distinct layers
2. **Dependency Injection**: Using GetIt for service management
3. **State Management**: Provider pattern for reactive UI updates
4. **Repository Pattern**: Abstracting data sources
5. **MVVM Pattern**: Separation of UI and business logic


