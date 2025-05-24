# Mini Project – “Music Services Module (Single Screen)”


## Project Overview

This Flutter application is an assignment for flutter developer role by S.Rocks.Music. It lists various music platforms with their details and icons, following a clean UI/UX approach.

## Services Offered

- **Music Production**: Professional music creation and arrangement
- **Lyrics Writing**: Expert lyric composition and songwriting
- **Mixing & Mastering**: High-quality audio mixing and mastering services
- **Vocal Composition**: Professional vocal arrangement and composition
- **Genre-Specific Production**: Specialized production across diverse music genres

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
git clone [repository-url]
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

## Development Approach

The project follows these key principles:

1. **Clean Architecture**: Separation of concerns with distinct layers
2. **Dependency Injection**: Using GetIt for service management
3. **State Management**: Provider pattern for reactive UI updates
4. **Repository Pattern**: Abstracting data sources
5. **MVVM Pattern**: Separation of UI and business logic


