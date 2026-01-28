# Contributing to Flutter MVVM Architecture Template

Thank you for your interest in contributing to the Flutter MVVM Architecture Template! We welcome contributions from everyone and appreciate your help in making this project better.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Reporting Issues](#reporting-issues)

## 🤝 Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment. Please:

- Be respectful and considerate
- Use welcoming and inclusive language
- Focus on constructive feedback
- Be open to different viewpoints and approaches

## 🚀 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find that the problem has already been reported. When creating a bug report, include:

- **Title**: A clear and descriptive title
- **Description**: A detailed description of the problem
- **Steps to Reproduce**: Steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Screenshots**: Include screenshots if applicable
- **Environment**: 
  - Flutter version
  - Dart version
  - OS version
  - Device/emulator details

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Title**: A clear and descriptive title
- **Description**: A detailed description of the enhancement
- **Motivation**: Why would this enhancement be useful?
- **Examples**: Examples or mockups if applicable

### Pull Requests

Pull requests are the best way to propose changes to the codebase. We actively welcome your pull requests:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK >= 3.1.5
- Dart SDK >= 3.1.5
- Git
- An IDE (VS Code or Android Studio)

### Setting Up Locally

1. **Fork and clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/GETX-MVVM-Acrchitecture-FLUTTER.git
cd GETX-MVVM-Acrchitecture-FLUTTER
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

4. **Run tests**
```bash
flutter test
```

5. **Analyze code**
```bash
flutter analyze
```

## 📝 Pull Request Process

### Before Submitting

1. **Check existing issues**: Make sure there isn't already an open PR for the same issue
2. **Update documentation**: If you're adding new features, update the README and inline documentation
3. **Write tests**: Add tests for new features or fix failing tests
4. **Format code**: Run `dart format .` to format your code
5. **Analyze code**: Run `flutter analyze` to check for issues

### PR Guidelines

When submitting a PR:

- **Title**: Use a clear and descriptive title (e.g., "Add user authentication feature")
- **Description**: Provide a detailed description of your changes
- **Related Issues**: Reference any related issues using `#issue-number`
- **Screenshots**: Include screenshots for UI changes
- **Breaking Changes**: Clearly document any breaking changes

### PR Checklist

Before submitting, ensure:

- [ ] Code follows the project's coding standards
- [ ] Tests have been added/updated and pass
- [ ] Documentation has been updated
- [ ] Code has been formatted (`dart format .`)
- [ ] Code passes analysis (`flutter analyze`)
- [ ] Commit messages are clear and descriptive

## 💻 Coding Standards

### Dart Style Guide

Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

- Use `camelCase` for variables and functions
- Use `PascalCase` for classes and types
- Use `lowercase_with_underscores` for file names
- Add doc comments for public APIs
- Keep lines under 80 characters when possible
- Use type annotations where the type isn't obvious

### Code Organization

- Follow the existing folder structure
- One class per file
- Keep files focused and small (<300 lines when possible)
- Use meaningful variable and function names
- Add inline comments for complex logic

### Example Code Style

```dart
// Good
class UserRepository {
  final BaseApiServices _apiServices;

  UserRepository(this._apiServices);

  /// Fetches user data from the API
  /// 
  /// Returns [UserModel] if successful
  /// Throws [AppException] on failure
  Future<UserModel> fetchUser(String userId) async {
    try {
      final response = await _apiServices.getGetApiResponse(
        '${AppUrl.users}/$userId'
      );
      return UserModel.fromJson(response);
    } catch (e) {
      throw AppException(message: 'Failed to fetch user');
    }
  }
}
```

### Git Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat: add user authentication
fix: resolve API connection timeout issue
docs: update README with new features
```

## 🐛 Reporting Issues

When reporting issues, please use the provided issue templates and provide as much detail as possible:

- Clear title
- Detailed description
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Screenshots/videos if applicable
- Relevant logs or error messages

## 📧 Getting Help

If you need help:

- Check the [documentation](README.md)
- Search existing [issues](../../issues)
- Start a [discussion](../../discussions)
- Contact maintainers

## 🎯 Priority Areas for Contribution

We particularly welcome contributions in:

1. **Documentation**: Improving code comments and README
2. **Tests**: Adding unit and widget tests
3. **Examples**: Creating more example screens and features
4. **Performance**: Optimizing code and reducing dependencies
5. **Accessibility**: Improving accessibility features
6. **Localization**: Adding more language support

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Thank You

Thank you for taking the time to contribute to this project! Every contribution helps make this template better for everyone.

---

For questions or clarifications, please open an issue or start a discussion.