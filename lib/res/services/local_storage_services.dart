import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'logger_services.dart';

/// Local Storage Service for handling all local data storage
/// Uses GetStorage for regular data and FlutterSecureStorage for sensitive data
class LocalStorageService {
  // GetStorage instance for regular data
  static GetStorage? _storage;

  // FlutterSecureStorage instance for sensitive data
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Storage Keys
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'locale';
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyEmail = 'email';
  static const String _keyUserData = 'user_data';
  static const String _keyFcmToken = 'fcm_token';
  static const String _keyUserRole = 'user-role';

  /// Initialize the storage service
  static Future<void> init() async {
    try {
      _storage = GetStorage();
      LoggerService.info('✅ LocalStorageService initialized successfully');
    } catch (e) {
      LoggerService.error('❌ Failed to initialize LocalStorageService', e);
      rethrow;
    }
  }

  // ==================== Theme Management ====================

  /// Save theme mode to storage
  static void setThemeMode(ThemeMode themeMode) {
    try {
      _storage?.write(_keyThemeMode, themeMode.index);
      LoggerService.info('💾 Theme mode saved: ${themeMode.name}');
    } catch (e) {
      LoggerService.error('❌ Failed to save theme mode', e);
    }
  }

  /// Get theme mode from storage
  static ThemeMode getThemeMode() {
    try {
      final index = _storage?.read(_keyThemeMode) ?? 0;
      final themeMode = ThemeMode.values[index];
      LoggerService.info('📖 Theme mode retrieved: ${themeMode.name}');
      return themeMode;
    } catch (e) {
      LoggerService.error('❌ Failed to get theme mode', e);
      return ThemeMode.system; // Default fallback
    }
  }

  // ==================== Locale Management ====================

  /// Save locale to storage
  static void setLocale(Locale locale) {
    try {
      final countryCode = locale.countryCode;
      final value = countryCode == null || countryCode.isEmpty
          ? locale.languageCode
          : '${locale.languageCode}_$countryCode';
      _storage?.write(_keyLocale, value);
      LoggerService.info('💾 Locale saved: $value');
    } catch (e) {
      LoggerService.error('❌ Failed to save locale', e);
    }
  }

  /// Get locale from storage
  static Locale getLocale() {
    try {
      final localeString = _storage?.read(_keyLocale) ?? 'en_US';
      final parts = localeString.split('_');
      final languageCode = parts[0];
      final countryCode = parts.length > 1 && parts[1].isNotEmpty
          ? parts[1]
          : null;
      final locale = countryCode == null
          ? Locale(languageCode)
          : Locale(languageCode, countryCode);
      LoggerService.info('📖 Locale retrieved: $localeString');
      return locale;
    } catch (e) {
      LoggerService.error('❌ Failed to get locale', e);
      return const Locale('en', 'US'); // Default fallback
    }
  }

  // ==================== First Time App Launch ====================

  /// Check if this is the first time opening the app
  static bool isFirstTime() {
    try {
      return _storage?.read(_keyIsFirstTime) ?? true;
    } catch (e) {
      LoggerService.error('❌ Failed to check first time status', e);
      return true;
    }
  }

  /// Mark app as opened (not first time anymore)
  static void setNotFirstTime() {
    try {
      _storage?.write(_keyIsFirstTime, false);
      LoggerService.info('💾 App marked as not first time');
    } catch (e) {
      LoggerService.error('❌ Failed to set first time status', e);
    }
  }

  // ==================== Token Management (Secure) ====================

  /// Save access token securely
  static Future<void> setAccessToken(String token) async {
    try {
      await _secureStorage.write(key: _keyAccessToken, value: token);
      LoggerService.info('💾 Access token saved securely');
    } catch (e) {
      LoggerService.error('❌ Failed to save access token', e);
    }
  }

  /// Get access token from secure storage
  static Future<String?> getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: _keyAccessToken);
      LoggerService.info('📖 Access token retrieved from secure storage');
      return token;
    } catch (e) {
      LoggerService.error('❌ Failed to get access token', e);
      return null;
    }
  }

  /// Save refresh token securely
  static Future<void> setRefreshToken(String token) async {
    try {
      await _secureStorage.write(key: _keyRefreshToken, value: token);
      LoggerService.info('💾 Refresh token saved securely');
    } catch (e) {
      LoggerService.error('❌ Failed to save refresh token', e);
    }
  }

  /// Get refresh token from secure storage
  static Future<String?> getRefreshToken() async {
    try {
      final token = await _secureStorage.read(key: _keyRefreshToken);
      LoggerService.info('📖 Refresh token retrieved from secure storage');
      return token;
    } catch (e) {
      LoggerService.error('❌ Failed to get refresh token', e);
      return null;
    }
  }

  /// Clear all tokens (logout)
  static Future<void> clearTokens() async {
    try {
      await _secureStorage.delete(key: _keyAccessToken);
      await _secureStorage.delete(key: _keyRefreshToken);
      LoggerService.info('🗑️ All tokens cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear tokens', e);
    }
  }

  /// Save user id securely
  static Future<void> setUserId(String token) async {
    try {
      await _secureStorage.write(key: _keyUserId, value: token);
      LoggerService.info('💾 User Id saved securely');
    } catch (e) {
      LoggerService.error('❌ Failed to save user ID', e);
    }
  }

  /// Get refresh token from secure storage
  static Future<String?> getUserId() async {
    try {
      final token = await _secureStorage.read(key: _keyUserId);
      LoggerService.info('📖 User Id retrieved from secure storage');
      return token;
    } catch (e) {
      LoggerService.error('❌ Failed to get User Id', e);
      return null;
    }
  }

  /// Clear all tokens (logout)
  static Future<void> clearUserId() async {
    try {
      await _secureStorage.delete(key: _keyUserId);
      // await _secureStorage.delete(key: _keyUserId);
      LoggerService.info('🗑️ All tokens cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear tokens', e);
    }
  }

  /// Save user email securely
  static Future<void> setEmail(String email) async {
    try {
      await _secureStorage.write(key: _keyEmail, value: email);
      LoggerService.info('💾 Email saved securely');
    } catch (e) {
      LoggerService.error('❌ Failed to save Email', e);
    }
  }

  /// Get user email from secure storage
  static Future<String?> getEmail() async {
    try {
      final email = await _secureStorage.read(key: _keyEmail);
      LoggerService.info('📖 Email retrieved from secure storage');
      return email;
    } catch (e) {
      LoggerService.error('❌ Failed to get Email', e);
      return null;
    }
  }

  /// Clear email (logout)
  static Future<void> clearEmail() async {
    try {
      await _secureStorage.delete(key: _keyEmail);
      LoggerService.info('🗑️ Email cleared from secure storage');
    } catch (e) {
      LoggerService.error('❌ Failed to clear Email', e);
    }
  }

  // ==================== FCM Token Management ====================

  /// Save FCM token
  static Future<void> saveFcmToken(String token) async {
    try {
      _storage?.write(_keyFcmToken, token);
      LoggerService.info('💾 FCM token saved');
    } catch (e) {
      LoggerService.error('❌ Failed to save FCM token', e);
    }
  }

  /// Get FCM token
  static String? getFcmToken() {
    try {
      final token = _storage?.read<String>(_keyFcmToken);
      LoggerService.info('📖 FCM token retrieved');
      return token;
    } catch (e) {
      LoggerService.error('❌ Failed to get FCM token', e);
      return null;
    }
  }

  /// Clear FCM token
  static Future<void> clearFcmToken() async {
    try {
      _storage?.remove(_keyFcmToken);
      LoggerService.info('🗑️ FCM token cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear FCM token', e);
    }
  }

  // ==================== User Data Management ====================

  /// Save user data
  static void setUserData(Map<String, dynamic> userData) {
    try {
      _storage?.write(_keyUserData, userData);
      LoggerService.info('💾 User data saved');
    } catch (e) {
      LoggerService.error('❌ Failed to save user data', e);
    }
  }

  /// Get user data
  static Map<String, dynamic>? getUserData() {
    try {
      final userData = _storage?.read(_keyUserData);
      LoggerService.info('📖 User data retrieved');
      return userData;
    } catch (e) {
      LoggerService.error('❌ Failed to get user data', e);
      return null;
    }
  }

  /// Clear user data
  static Future<void> clearUserData() async {
    try {
      // Clear secure tokens and identifiers
      await clearTokens();
      await clearUserId();

      // Clear any role stored in regular storage
      await clearUserRole();
      await clearEmail();

      // Remove stored user data map
      _storage?.remove(_keyUserData);
      LoggerService.info('🗑️ User data and credentials cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear user data', e);
    }
  }

  // ==================== General Storage Methods ====================

  /// Write any data to storage
  static Future<void> write(String key, dynamic value) async {
    try {
      _storage?.write(key, value);
      LoggerService.info('💾 Data saved with key: $key');
    } catch (e) {
      LoggerService.error('❌ Failed to save data with key: $key', e);
    }
  }

  static Future<void> setUserRole(String key, dynamic value) async {
    try {
      _storage?.write(key, value);
      LoggerService.info('💾 User role saved with key: $key');
    } catch (e) {
      LoggerService.error('❌ Failed to save user role with key: $key', e);
    }
  }

  static Future<String?> getUserRole() async {
    try {
      final userRole = await _storage?.read(_keyUserRole);
      LoggerService.info('💾 User role retrieved with key: $_keyUserRole');
      return userRole;
    } catch (e) {
      LoggerService.error('❌ Failed to get user role with key: user-role', e);
      return null;
    }
  }

  static Future<void> clearUserRole() async {
    try {
      await _storage?.remove(_keyUserRole);
      LoggerService.info('🗑️ User role cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear user role', e);
    }
  }

  /// Read any data from storage
  static T? read<T>(String key) {
    try {
      final value = _storage?.read<T>(key);
      LoggerService.info('📖 Data retrieved with key: $key');
      return value;
    } catch (e) {
      LoggerService.error('❌ Failed to read data with key: $key', e);
      return null;
    }
  }

  /// Remove data from storage
  static void remove(String key) {
    try {
      _storage?.remove(key);
      LoggerService.info('🗑️ Data removed with key: $key');
    } catch (e) {
      LoggerService.error('❌ Failed to remove data with key: $key', e);
    }
  }

  /// Clear all storage data
  static void clearAll() {
    try {
      _storage?.erase();
      LoggerService.info('🗑️ All storage data cleared');
    } catch (e) {
      LoggerService.error('❌ Failed to clear all storage data', e);
    }
  }

  /// Check if key exists in storage
  static bool hasData(String key) {
    try {
      return _storage?.hasData(key) ?? false;
    } catch (e) {
      LoggerService.error('❌ Failed to check if key exists: $key', e);
      return false;
    }
  }
}
