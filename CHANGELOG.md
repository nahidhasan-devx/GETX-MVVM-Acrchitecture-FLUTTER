# Changelog

All notable changes to the Flutter MVVM Architecture Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- [ ] Add comprehensive unit tests
- [ ] Add widget tests
- [ ] Add integration tests
- [ ] Add more example screens
- [ ] Add dark mode support
- [ ] Add more localization languages
- [ ] Add biometric authentication example
- [ ] Add offline caching example
- [ ] Add WebSocket support example
- [ ] Add video player example
- [ ] Add image picker and upload example
- [ ] Add push notifications setup
- [ ] Add analytics integration
- [ ] Add crash reporting setup

## [1.0.0] - 2026-01-28

### Added
- Initial release of Flutter MVVM Architecture Template
- MVVM architecture implementation with GetX
- Clean folder structure following best practices
- Repository pattern for data access
- Base API services for network operations
- Centralized exception handling
- Exception widgets (GeneralExceptionWidget, InternetExceptionWidget)
- Reusable UI components (RoundButton)
- Local storage services (shared_preferences, get_storage)
- Secure storage support (flutter_secure_storage)
- Logger service for debugging
- GetX routing and navigation setup
- Localization support with GetX
- App-wide constants (colors, fonts, assets, routes)
- Example screens:
  - Splash screen
  - Login screen with API integration
  - Home screen with user list
- Example models:
  - Login response model
  - User list model
- Example repositories:
  - Login repository
  - Home repository
- Example view models:
  - Login view model
  - Home view model
  - User preferences view model
- Comprehensive README with usage examples
- CONTRIBUTING guidelines
- MIT License

### Dependencies
- get: ^4.6.6
- http: ^1.1.0
- shared_preferences: ^2.2.2
- flutter_secure_storage: ^10.0.0
- get_storage: ^2.1.1
- fluttertoast: ^8.2.2
- logger: ^2.6.2

---

[Unreleased]: https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/nahidhasan-devx/GETX-MVVM-Acrchitecture-FLUTTER/releases/tag/v1.0.0