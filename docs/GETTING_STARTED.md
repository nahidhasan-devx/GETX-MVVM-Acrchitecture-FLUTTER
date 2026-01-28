# Getting Started Guide

This guide will help you get started with the Flutter MVVM Architecture Template and understand how to use it effectively.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure Overview](#project-structure-overview)
- [Understanding the Architecture](#understanding-the-architecture)
- [Adding Your First Feature](#adding-your-first-feature)
- [Common Tasks](#common-tasks)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

## Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Flutter SDK**: [Download and install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Included with Flutter SDK
- **Git**: [Download Git](https://git-scm.com/downloads)
- **IDE**: 
  - [Visual Studio Code](https://code.visualstudio.com/) (recommended)
  - [Android Studio](https://developer.android.com/studio)

### Recommended VS Code Extensions

1. **Flutter** - by Dart Code
2. **Dart** - by Dart Code
3. **GitLens** - for Git integration
4. **Error Lens** - for inline error display

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER.git
cd GETX-MVVM-Acrchitecture-FLUTTER
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Verify Flutter Setup

```bash
flutter doctor
```

This will check your Flutter environment and display any issues.

### 4. Run the Application

```bash
flutter run
```

Or if you want to run on a specific device:

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

## Project Structure Overview

Let's take a quick tour of the project structure:

```
lib/
├── main.dart                    # App entry point
├── data/                        # Data layer (API, exceptions)
├── models/                      # Data models
├── repository/                  # Data repositories
├── res/                         # Resources (colors, fonts, routes)
├── screen/                      # UI screens
├── utils/                       # Utility functions
└── view_model/                  # ViewModels (controllers)
```

### Key Files to Know

- **`main.dart`**: App initialization and service setup
- **`my_app.dart`**: Root widget configuration
- **`lib/res/app_url/app_url.dart`**: API endpoints
- **`lib/res/routes/routes.dart`**: Route definitions
- **`lib/res/colors/app_colors.dart`**: App color scheme

## Understanding the Architecture

This template uses the MVVM (Model-View-ViewModel) architecture pattern. Here's how it works:

### Flow Diagram

```
User Input
    ↓
View (Screen)
    ↓
ViewModel (Controller)
    ↓
Repository
    ↓
API Service
    ↓
Network
    ↓
Model (Data)
    ↓
ViewModel (Update State)
    ↓
View (Rebuild)
```

### Example Flow

1. **User** clicks a button on the **LoginScreen** (View)
2. **LoginViewModel** receives the click event
3. **LoginViewModel** calls **LoginRepository**
4. **LoginRepository** uses **NetworkApiServices**
5. **NetworkApiServices** makes HTTP request to API
6. **LoginResponseModel** parses the response
7. **LoginViewModel** updates its state
8. **LoginScreen** rebuilds with new data via `Obx()`

## Adding Your First Feature

Let's add a simple "Profile" screen to demonstrate the architecture.

### Step 1: Create the Model

Create `lib/models/profile/profile_model.dart`:

```dart
class ProfileModel {
  final String name;
  final String email;
  final String avatar;

  ProfileModel({
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
```

### Step 2: Create the Repository

Create `lib/repository/profile_repository/profile_repository.dart`:

```dart
import 'package:getx_mvvm/data/network/base_api_services.dart';
import 'package:getx_mvvm/data/network/network_api_services.dart';
import 'package:getx_mvvm/models/profile/profile_model.dart';
import 'package:getx_mvvm/res/app_url/app_url.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ProfileModel> fetchProfile(String userId) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        '${AppUrl.profileApi}/$userId'
      );
      return ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
```

### Step 3: Add API Endpoint

Update `lib/res/app_url/app_url.dart`:

```dart
class AppUrl {
  static const String baseUrl = 'https://api.example.com';
  static const String loginApi = '/login';
  static const String homeApi = '/home';
  static const String profileApi = '/profile'; // Add this
}
```

### Step 4: Create the ViewModel

Create `lib/view_model/controller/profile/profile_view_model.dart`:

```dart
import 'package:get/get.dart';
import 'package:getx_mvvm/models/profile/profile_model.dart';
import 'package:getx_mvvm/repository/profile_repository/profile_repository.dart';
import 'package:getx_mvvm/data/response/status.dart';

class ProfileViewModel extends GetxController {
  final _profileRepo = ProfileRepository();

  final rxRequestStatus = Status.loading.obs;
  final profile = ProfileModel(
    name: '',
    email: '',
    avatar: '',
  ).obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setProfile(ProfileModel value) => profile.value = value;

  Future<void> fetchProfileApi(String userId) async {
    setRxRequestStatus(Status.loading);
    _profileRepo.fetchProfile(userId).then((value) {
      setProfile(value);
      setRxRequestStatus(Status.completed);
    }).onError((error, stackTrace) {
      setRxRequestStatus(Status.error);
    });
  }
}
```

### Step 5: Create the Screen

Create `lib/screen/profile/profile_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/components/general_exception_widget.dart';
import 'package:getx_mvvm/res/colors/app_colors.dart';
import 'package:getx_mvvm/view_model/controller/profile/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileViewModel viewModel = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    // Fetch profile data
    viewModel.fetchProfileApi('123');

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColors.buttonColor,
      ),
      body: Obx(() {
        switch (viewModel.rxRequestStatus.value) {
          case Status.loading:
            return Center(child: CircularProgressIndicator());
          case Status.completed:
            return _buildProfileContent();
          case Status.error:
            return GeneralExceptionWidget(
              onPress: () => viewModel.fetchProfileApi('123'),
            );
          default:
            return SizedBox();
        }
      }),
    );
  }

  Widget _buildProfileContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(viewModel.profile.value.avatar),
          ),
          SizedBox(height: 20),
          Text(
            viewModel.profile.value.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            viewModel.profile.value.email,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
```

### Step 6: Add Route Name

Update `lib/res/routes/routes_name.dart`:

```dart
class RoutesName {
  static const String splashScreen = '/';
  static const String loginScreen = '/login';
  static const String homeScreen = '/home';
  static const String profileScreen = '/profile'; // Add this
}
```

### Step 7: Add Route

Update `lib/res/routes/routes.dart`:

```dart
GetPage(
  name: RoutesName.profileScreen,
  page: () => const ProfileScreen(),
  transitionDuration: const Duration(milliseconds: 250),
  transition: Transition.leftToRight,
),
```

### Step 8: Navigate to Profile

You can now navigate to the profile screen:

```dart
Get.toNamed(RoutesName.profileScreen);
```

## Common Tasks

### Making API Calls

```dart
// In your repository
Future<dynamic> fetchData() async {
  try {
    dynamic response = await _apiServices.getGetApiResponse(AppUrl.yourEndpoint);
    return response;
  } catch (e) {
    rethrow;
  }
}

// In your ViewModel
Future<void> loadData() async {
  try {
    setRxRequestStatus(Status.loading);
    dynamic data = await _repo.fetchData();
    // Process data
    setRxRequestStatus(Status.completed);
  } catch (e) {
    setRxRequestStatus(Status.error);
    Utils.flushBarErrorMessage(e.toString(), Get.context!);
  }
}
```

### Using Local Storage

```dart
// Using Shared Preferences
await LocalStorageService.saveString('key', 'value');
String? value = LocalStorageService.getString('key');

// Using Get Storage
final box = GetStorage();
box.write('key', 'value');
String? value = box.read('key');

// Using Secure Storage
final storage = FlutterSecureStorage();
await storage.write(key: 'key', value: 'value');
String? value = await storage.read(key: 'key');
```

### Showing Toast Messages

```dart
Utils.toastMessage('Success message');
Utils.flushBarErrorMessage('Error message', Get.context!);
```

### Navigating Between Screens

```dart
// Navigate to screen
Get.toNamed(RoutesName.homeScreen);

// Navigate and remove previous
Get.offNamed(RoutesName.homeScreen);

// Navigate and remove all (like login flow)
Get.offAllNamed(RoutesName.homeScreen);

// Go back
Get.back();

// With arguments
Get.toNamed(RoutesName.userScreen, arguments: {'userId': '123'});

// Access arguments
final args = Get.arguments;
String userId = args['userId'];
```

### Using Reactive Variables

```dart
// In ViewModel
final counter = 0.obs;
final items = <String>[].obs;
final userData = UserModel().obs;

// Update values
counter.value++;
items.add('New item');
userData.value = newUser;

// In View
Obx(() => Text('Count: ${viewModel.counter.value}'))
```

## Best Practices

### 1. Keep ViewModels Focused

Each ViewModel should handle one screen or feature. Don't make them too large.

### 2. Use Reactive Variables Wisely

Only make variables reactive when needed. Not all variables need `.obs`.

### 3. Handle Errors Properly

Always handle exceptions in ViewModels and show user-friendly messages.

### 4. Use Constants

Store strings, numbers, and configurations in constants files.

### 5. Write Tests

Write unit tests for ViewModels and widget tests for UI components.

### 6. Follow Flutter Guidelines

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines.

### 7. Optimize Performance

- Use `const` widgets where possible
- Avoid unnecessary rebuilds
- Use `Get.lazyPut()` for memory efficiency

## Troubleshooting

### Build Errors

**Problem**: Build fails after updating dependencies

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

### Import Errors

**Problem**: Can't find import

**Solution**:
1. Check if the file exists
2. Verify the import path
3. Run `flutter pub get`
4. Restart your IDE

### State Not Updating

**Problem**: UI not updating when state changes

**Solution**:
1. Make sure you're using `Obx()` or `GetBuilder()`
2. Verify variables are reactive (have `.obs`)
3. Check if `update()` is called in ViewModel

### API Errors

**Problem**: API calls failing

**Solution**:
1. Check network connection
2. Verify API endpoint URL
3. Check if API server is running
4. Review exception message in logs

### Hot Reload Issues

**Problem**: Hot reload not working

**Solution**:
```bash
# Try hot restart instead
# Press 'R' in terminal or use IDE option

# Or restart the app completely
flutter run
```

## Resources

### Official Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [GetX Documentation](https://pub.dev/packages/get)

### Project Documentation

- [README.md](../README.md) - Project overview
- [ARCHITECTURE.md](./ARCHITECTURE.md) - Architecture details
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines

### Community

- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [GitHub Issues](https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER/issues)

### Tutorials

- [Flutter Tutorials](https://flutter.dev/docs/codelabs)
- [GetX Tutorials](https://pub.dev/documentation/get/latest)

## Next Steps

Now that you understand the basics, you can:

1. Explore the example screens in the project
2. Read the [Architecture Documentation](./ARCHITECTURE.md)
3. Start building your own features
4. Contribute to the project

## Support

If you need help:

1. Check the [GitHub Issues](https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER/issues)
2. Create a new issue with detailed information
3. Join the community discussions

Happy coding! 🚀