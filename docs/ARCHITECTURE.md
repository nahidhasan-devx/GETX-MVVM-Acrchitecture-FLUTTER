# Architecture Documentation

This document provides a comprehensive overview of the MVVM architecture pattern implemented in this Flutter template using GetX.

## Table of Contents

- [Overview](#overview)
- [MVVM Pattern](#mvvm-pattern)
- [Project Structure](#project-structure)
- [Data Layer](#data-layer)
- [Domain Layer](#domain-layer)
- [Presentation Layer](#presentation-layer)
- [Dependency Injection](#dependency-injection)
- [State Management](#state-management)
- [Routing](#routing)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)

## Overview

This template implements a clean, scalable MVVM (Model-View-ViewModel) architecture pattern with GetX state management. The architecture is designed to:

- **Separate concerns**: Each layer has a specific responsibility
- **Promote reusability**: Components can be easily reused across the app
- **Improve testability**: Business logic is isolated from UI
- **Enhance maintainability**: Code is organized and easy to navigate
- **Support scalability**: Architecture grows with application complexity

## MVVM Pattern

### Model
The Model represents the data and business logic of the application.

**Responsibilities:**
- Data structures and classes
- Repository pattern for data access
- API service abstractions
- Business logic implementation

**Location:** `lib/models/`, `lib/repository/`, `lib/data/`

### View
The View represents the UI layer that displays data to the user.

**Responsibilities:**
- UI rendering
- User input handling
- Displaying data from ViewModel
- No business logic

**Location:** `lib/screen/`, `lib/res/components/`

### ViewModel
The ViewModel acts as the intermediary between View and Model.

**Responsibilities:**
- State management
- Business logic coordination
- Data transformation
- User interaction handling
- Command implementation

**Location:** `lib/view_model/`

## Project Structure

```
lib/
├── data/                          # Data layer
│   ├── app_exceptions.dart       # Custom exceptions
│   ├── network/                  # Network services
│   │   ├── base_api_services.dart     # Abstract API service
│   │   └── network_api_services.dart  # Concrete API implementation
│   └── response/                 # Response handling
│       ├── api_response.dart          # Generic API response wrapper
│       └── status.dart                # API status enum
│
├── models/                       # Data models
│   ├── home/
│   │   └── user_list_model.dart
│   └── login/
│       └── login_response_model.dart
│
├── repository/                   # Repository pattern
│   ├── home_repository/
│   │   └── home_repository.dart
│   └── login_repository/
│       └── login_repository.dart
│
├── res/                          # Resources
│   ├── app_url/                  # API endpoints
│   ├── assets/                   # Asset constants
│   ├── colors/                   # Color scheme
│   ├── components/               # Reusable widgets
│   ├── fonts/                    # Font configurations
│   ├── getx_localization/        # Localization
│   ├── routes/                   # Routing
│   └── services/                 # Core services
│
├── screen/                       # UI screens
├── utils/                        # Utilities
├── view_model/                   # ViewModels
│   ├── controller/               # GetX controllers
│   └── services/                 # ViewModel services
│
├── main.dart                     # App entry point
└── my_app.dart                   # Root widget
```

## Data Layer

The data layer is responsible for handling all data operations.

### API Services

**BaseApiServices** (`lib/data/network/base_api_services.dart`)
- Abstract class defining API contract
- Methods: GET, POST, PUT, DELETE
- Ensures consistency across implementations

**NetworkApiServices** (`lib/data/network/network_api_services.dart`)
- Concrete implementation using `http` package
- Handles actual network requests
- Returns parsed responses or throws exceptions

### Exception Handling

**AppException** (`lib/data/app_exceptions.dart`)
- Custom exception classes for different error scenarios:
  - `BadRequestException`
  - `UnauthorizedException`
  - `NotFoundException`
  - `ServerException`
  - `InternetException`

**ApiResponse** (`lib/data/response/api_response.dart`)
- Generic wrapper for API responses
- Contains status, data, and message
- Type-safe response handling

**Status** (`lib/data/response/status.dart`)
- Enum for API status:
  - `loading`: Request in progress
  - `completed`: Request successful
  - `error`: Request failed

### Repository Pattern

Repositories abstract data sources and provide a clean API for ViewModels.

**Benefits:**
- Single source of truth for data
- Easy to mock for testing
- Can switch data sources without affecting ViewModels
- Centralizes data logic

**Example:**
```dart
class LoginRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.loginApi,
        data
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
```

## Domain Layer

The domain layer contains business logic and data models.

### Models

Models represent the data structure of your application.

**Best Practices:**
- Use `fromJson()` and `toJson()` for serialization
- Use immutable classes where possible
- Include validation logic
- Document fields with comments

**Example:**
```dart
class LoginResponseModel {
  final String token;
  final User? user;

  LoginResponseModel({required this.token, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }
}
```

## Presentation Layer

The presentation layer handles UI and user interaction.

### Screens

Screens are the building blocks of your UI.

**Guidelines:**
- Keep screens focused and simple
- Delegate logic to ViewModels
- Use GetX for state observation
- Separate UI from business logic

**Example:**
```dart
class LoginScreen extends StatelessWidget {
  final loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => Text(loginViewModel.email.value)),
            Obx(() => Text(loginViewModel.password.value)),
            RoundButton(
              title: 'Login',
              onPress: () => loginViewModel.loginApi(),
            ),
          ],
        ),
      ),
    );
  }
}
```

### ViewModels

ViewModels manage the state and business logic for screens.

**Guidelines:**
- Extend `GetxController`
- Use `.obs` for reactive variables
- Use `update()` to notify listeners
- Keep ViewModels focused on one screen/feature

**Example:**
```dart
class LoginViewModel extends GetxController {
  final _api = LoginRepository();
  final _userPreference = UserPreferencesView();

  final email = ''.obs;
  final password = ''.obs;
  final loading = false.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  Future<void> loginApi() async {
    loading.value = true;
    
    try {
      dynamic data = await _api.login({
        'email': email.value,
        'password': password.value,
      });
      
      await _userPreference.saveUser(LoginResponseModel.fromJson(data));
      Get.toNamed(RoutesName.home);
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), Get.context!);
    } finally {
      loading.value = false;
    }
  }
}
```

## Dependency Injection

This template uses GetX's dependency injection system.

### Injection Methods

**Get.put()**
- Injects immediately
- Used when controller is needed right away
- Good for controllers needed on page load

**Get.lazyPut()**
- Injects only when first used
- Saves memory
- Good for controllers used conditionally

**Get.putAsync()**
- For async initialization
- Returns a Future
- Good for controllers requiring setup time

### Example
```dart
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
```

## State Management

This template uses GetX for reactive state management.

### Reactive Variables

Use `.obs` to make variables reactive:
```dart
final count = 0.obs;
final isLoading = false.obs;
final userData = UserModel().obs;
```

### Observing Changes

Use `Obx()` or `GetBuilder()` to observe changes:

**Obx()**
- More efficient
- Only rebuilds when observed variables change
- Recommended for most cases

```dart
Obx(() => Text('Count: ${count.value}'))
```

**GetBuilder()**
- Rebuilds entire widget when `update()` is called
- Good for complex state changes
- More explicit control

```dart
GetBuilder<Controller>(
  init: Controller(),
  builder: (controller) => Text('Count: ${controller.count}'),
)
```

### Worker Methods

GetX provides worker methods for side effects:

**ever()**
- Runs every time the variable changes
```dart
ever(count, (value) => print('Count changed to $value'));
```

**everAll()**
- Runs when any of the listed variables change
```dart
everAll([count, name], (values) => print('Changed'));
```

**once()**
- Runs only once when the variable first changes
```dart
once(count, (value) => print('Count changed to $value'));
```

**debounce()**
- Runs after a delay
```dart
debounce(searchQuery, (value) => performSearch(), time: Duration(seconds: 1));
```

**interval()**
- Runs at regular intervals
```dart
interval(count, (value) => print('Count: $value'), time: Duration(seconds: 1));
```

## Routing

This template uses GetX for navigation and routing.

### Route Definition

Routes are defined in `lib/res/routes/routes.dart`:
```dart
GetPage(
  name: RoutesName.loginScreen,
  page: () => const LoginScreen(),
  transitionDuration: const Duration(milliseconds: 250),
  transition: Transition.leftToRight,
)
```

### Navigation Methods

**Navigate to screen:**
```dart
Get.toNamed(RoutesName.loginScreen);
```

**Navigate and remove previous:**
```dart
Get.offNamed(RoutesName.homeScreen);
```

**Navigate and remove all:**
```dart
Get.offAllNamed(RoutesName.homeScreen);
```

**Back navigation:**
```dart
Get.back();
```

**With arguments:**
```dart
Get.toNamed(RoutesName.userScreen, arguments: {'userId': '123'});
```

**Access arguments:**
```dart
final args = Get.arguments;
final userId = args['userId'];
```

## Error Handling

This template provides comprehensive error handling.

### Exception Widgets

**GeneralExceptionWidget**
- Displays general error messages
- Provides retry functionality
- Used for API errors, validation errors, etc.

**InternetExceptionWidget**
- Displays internet connection errors
- Provides retry functionality
- Used when network is unavailable

### Usage

```dart
Obx(() {
  switch (apiResponse.status) {
    case Status.loading:
      return CircularProgressIndicator();
    case Status.completed:
      return YourDataWidget(data: apiResponse.data);
    case Status.error:
      return GeneralExceptionWidget(
        onPress: () => viewModel.fetchData(),
      );
  }
  return SizedBox();
});
```

## Best Practices

### 1. Keep Layers Separate
- Never import View in Model
- Never import Model in View
- Use ViewModel to bridge them

### 2. Use Constants
- Store strings, numbers, and configurations in constants
- Use `lib/res/` for app-wide constants
- Avoid magic numbers and strings

### 3. Error Handling
- Always handle exceptions in ViewModels
- Provide user-friendly error messages
- Use exception widgets for consistent error display

### 4. Dependency Injection
- Inject dependencies using GetX
- Use `Get.lazyPut()` for better performance
- Dispose controllers when not needed

### 5. State Management
- Keep ViewModels focused on one screen
- Use reactive variables for state
- Use `update()` sparingly

### 6. Code Organization
- One class per file
- Keep files under 300 lines
- Use meaningful names
- Add documentation comments

### 7. Testing
- Write unit tests for ViewModels
- Write widget tests for UI
- Mock repositories in tests

### 8. Performance
- Use `const` widgets where possible
- Avoid unnecessary rebuilds
- Use `Get.lazyPut()` for memory efficiency

### 9. Security
- Never store sensitive data in plain text
- Use `flutter_secure_storage` for sensitive data
- Validate all inputs
- Use HTTPS for all network calls

### 10. Documentation
- Document public APIs
- Add comments for complex logic
- Keep README up to date

## Conclusion

This MVVM architecture with GetX provides a solid foundation for building scalable Flutter applications. By following these guidelines and best practices, you can maintain code quality as your application grows.

For questions or contributions, please refer to the [CONTRIBUTING.md](../CONTRIBUTING.md) file.