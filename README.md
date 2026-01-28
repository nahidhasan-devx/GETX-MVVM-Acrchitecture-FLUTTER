<div align="center">

# Flutter MVVM Architecture Template with GetX

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-00C853?style=for-the-badge&logo=getx&logoColor=white)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](CONTRIBUTING.md)

A production-ready Flutter template implementing MVVM (Model-View-ViewModel) architecture with GetX state management. Provides a clean, scalable, and maintainable structure for building enterprise-grade Flutter applications.

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Folder Structure](#-folder-structure) • [Contributing](#-contributing)

</div>

---

## 🌟 Features

- ✅ **MVVM Architecture Pattern** - Clean separation of concerns with Model, View, and ViewModel layers
- ✅ **GetX State Management** - Efficient reactive state management and dependency injection
- ✅ **Clean API Layer** - Structured network handling with base services and repository pattern
- ✅ **Exception Handling** - Centralized error handling with user-friendly exception widgets
- ✅ **Local Storage Support** - Integrated with shared_preferences and flutter_secure_storage
- ✅ **Logging System** - Built-in logger service for debugging and monitoring
- ✅ **Internationalization Ready** - GetX localization support included
- ✅ **Responsive UI Components** - Reusable widgets with consistent styling
- ✅ **Type Safety** - Strongly typed models and API responses
- ✅ **Production Ready** - Optimized and tested for real-world applications

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

### Model
Represents the data and business logic. Includes:
- Data models for API responses
- Repository pattern for data access
- Base API services for network calls

### View
The UI layer that displays data to the user. Includes:
- Screens and widgets
- UI components
- No business logic, only presentation

### ViewModel
The intermediary between View and Model. Includes:
- GetX controllers for state management
- Business logic implementation
- Data transformation and validation

### Key Design Patterns
- **Repository Pattern**: Abstraction for data access
- **Dependency Injection**: GetX binding for loose coupling
- **Single Responsibility**: Each class has one clear purpose
- **Reactive Programming**: Streams and observables for state updates

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.1.5)
- Dart SDK (>=3.1.5)
- Android Studio / VS Code with Flutter plugins
- For iOS: Xcode (macOS only)
- For Android: Android SDK

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER.git
cd GETX-MVVM-Acrchitecture-FLUTTER
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the application**
```bash
flutter run
```

4. **Build for release**

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web
```

## 📁 Folder Structure

```
lib/
├── main.dart                    # App entry point
├── my_app.dart                  # Root widget configuration
│
├── data/                        # Data layer
│   ├── app_exceptions.dart      # Custom exception classes
│   ├── network/                 # Network services
│   │   ├── base_api_services.dart
│   │   └── network_api_services.dart
│   └── response/                # API response handling
│       ├── api_response.dart
│       └── status.dart
│
├── models/                      # Data models
│   ├── home/
│   │   └── user_list_model.dart
│   └── login/
│       └── login_response_model.dart
│
├── repository/                  # Repository pattern implementation
│   ├── home_repository/
│   │   └── home_repository.dart
│   └── login_repository/
│       └── login_repository.dart
│
├── res/                         # Resources and configurations
│   ├── app_url/
│   │   └── app_url.dart         # API endpoints
│   ├── assets/
│   │   └── image_assets.dart    # Asset constants
│   ├── colors/
│   │   └── app_colors.dart      # App color scheme
│   ├── components/              # Reusable widgets
│   │   ├── general_exception_widget.dart
│   │   ├── internet_exception_widget.dart
│   │   └── round_button.dart
│   ├── fonts/
│   │   └── app_fonts.dart       # Font configurations
│   ├── getx_localization/
│   │   └── languages.dart      # Localization setup
│   ├── routes/
│   │   ├── routes.dart          # Route definitions
│   │   └── routes_name.dart     # Route name constants
│   └── services/                # Core services
│       ├── local_storage_services.dart
│       └── logger_services.dart
│
├── screen/                      # UI screens
│   ├── splash_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   └── login/
│       └── login_screen.dart
│
├── utils/                       # Utility functions
│   └── utils.dart
│
└── view_model/                  # ViewModels (GetX controllers)
    ├── controller/              # State controllers
    │   ├── home/
    │   │   └── home_view_model.dart
    │   ├── login/
    │   │   └── login_view_model.dart
    │   └── user_preference/
    │       └── user_preferences_view_model.dart
    └── services/               # ViewModel services
        └── splash_services.dart
```

### Key Components Explained

- **data/**: Handles all data operations, API calls, and exception handling
- **models/**: Dart classes representing your data structures
- **repository/**: Abstracts data sources and implements business logic
- **res/**: Contains all resources like colors, fonts, routes, and constants
- **screen/**: All UI screens and widgets
- **view_model/**: GetX controllers managing state and business logic
- **utils/**: Helper functions and utilities

## 🛠️ How to Use This Template

### Adding a New Screen

1. **Create the Model** in `lib/models/`:
```dart
class YourModel {
  final String id;
  final String name;
  
  YourModel({required this.id, required this.name});
}
```

2. **Create the Repository** in `lib/repository/`:
```dart
class YourRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  
  Future<dynamic> fetchData() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.yourEndpoint);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
```

3. **Create the ViewModel** in `lib/view_model/controller/`:
```dart
class YourViewModel extends GetxController {
  final _repo = YourRepository();
  final _apiStatus = Status.loading;
  
  Status get apiStatus => _apiStatus;
  
  void fetchData() async {
    await _repo.fetchData();
    update();
  }
}
```

4. **Create the Screen** in `lib/screen/`:
```dart
class YourScreen extends StatelessWidget {
  final YourViewModel viewModel = Get.put(YourViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => YourWidget()),
    );
  }
}
```

5. **Add Route** in `lib/res/routes/routes.dart`:
```dart
GetPage(
  name: RoutesName.yourScreen,
  page: () => const YourScreen(),
  transitionDuration: const Duration(milliseconds: 250),
  transition: Transition.leftToRight,
),
```

6. **Add Route Name** in `lib/res/routes/routes_name.dart`:
```dart
static const String yourScreen = '/your-screen';
```

### API Integration

1. Define your API endpoints in `lib/res/app_url/app_url.dart`
2. Create API response models in `lib/models/`
3. Use the repository pattern to fetch data
4. Handle exceptions with the built-in exception widgets

### State Management

This template uses GetX for state management:
- Use `Get.put()` to inject controllers
- Use `Obx()` or `GetBuilder()` to rebuild UI on state changes
- Use `update()` to notify listeners of state changes

## 📦 Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| [get](https://pub.dev/packages/get) | ^4.6.6 | State management, routing, and dependency injection |
| [http](https://pub.dev/packages/http) | ^1.1.0 | HTTP requests |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.2.2 | Local storage |
| [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) | ^10.0.0 | Secure storage for sensitive data |
| [get_storage](https://pub.dev/packages/get_storage) | ^2.1.1 | Fast key-value storage |
| [fluttertoast](https://pub.dev/packages/fluttertoast) | ^8.2.2 | Toast notifications |
| [logger](https://pub.dev/packages/logger) | ^2.6.2 | Logging utility |

## 📝 Code Style

This project follows the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines. Run:

```bash
flutter analyze
```

to check for issues.

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest new features
- 📖 Improve documentation
- 🔧 Fix issues
- 🚀 Add new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Nahid Hasan**

- GitHub: [@nahidhasan-devx](https://github.com/nahidhasan-devx)

## 🙏 Acknowledgments

- [GetX](https://github.com/jonataslaw/getx) - The amazing state management solution
- [Flutter](https://flutter.dev) - The cross-platform UI toolkit

## ⭐ Show Your Support

If this template helped you, please give it a ⭐ star on GitHub!

---

<div align="center">

**Made with ❤️ using Flutter & GetX**

[⬆ Back to Top](#-flutter-mvvm-architecture-template-with-getx)

</div>