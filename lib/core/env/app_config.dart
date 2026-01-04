/// Application configuration and environment variables management
library app_config;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Appwrite Configuration - loaded from environment
  // Try dotenv first, then fall back to compile-time constants
  static String get appwriteEndpoint => 
      dotenv.env['APPWRITE_ENDPOINT']?.isNotEmpty == true
          ? dotenv.env['APPWRITE_ENDPOINT']!
          : const String.fromEnvironment('APPWRITE_ENDPOINT', defaultValue: '');
  
  static String get appwriteProjectId => 
      dotenv.env['APPWRITE_PROJECT_ID']?.isNotEmpty == true
          ? dotenv.env['APPWRITE_PROJECT_ID']!
          : const String.fromEnvironment('APPWRITE_PROJECT_ID', defaultValue: '');
  
  static String get appwriteDatabaseId => 
      dotenv.env['APPWRITE_DATABASE_ID']?.isNotEmpty == true
          ? dotenv.env['APPWRITE_DATABASE_ID']!
          : const String.fromEnvironment('APPWRITE_DATABASE_ID', defaultValue: '');
  
  static String get appwriteApiKey => 
      dotenv.env['APPWRITE_API_KEY']?.isNotEmpty == true
          ? dotenv.env['APPWRITE_API_KEY']!
          : const String.fromEnvironment('APPWRITE_API_KEY', defaultValue: '');
  
  // OAuth2 Configuration
  static const String appwriteCallbackScheme = 'onestep';
  
  // Gemini AI Configuration
  static String get geminiApiKey => 
      dotenv.env['GEMINI_API_KEY']?.isNotEmpty == true
          ? dotenv.env['GEMINI_API_KEY']!
          : const String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  
  // App Configuration
  static String get appName => 
      dotenv.env['APP_NAME']?.isNotEmpty == true
          ? dotenv.env['APP_NAME']!
          : const String.fromEnvironment('APP_NAME', defaultValue: 'OneStep');
  
  static String get appVersion => 
      dotenv.env['APP_VERSION']?.isNotEmpty == true
          ? dotenv.env['APP_VERSION']!
          : const String.fromEnvironment('APP_VERSION', defaultValue: '1.0.0');
  
  static bool get debugMode {
    final dotenvValue = dotenv.env['DEBUG_MODE']?.toLowerCase();
    if (dotenvValue != null) return dotenvValue == 'true';
    return const String.fromEnvironment('DEBUG_MODE', defaultValue: 'false').toLowerCase() == 'true';
  }
  
  // Database Configuration
  static const String localDatabaseName = 'onestep_local.db';
  static const int databaseVersion = 1;
  
  // Validation
  static bool get isConfigValid {
    return appwriteEndpoint.isNotEmpty &&
           appwriteProjectId.isNotEmpty &&
           appwriteDatabaseId.isNotEmpty;
  }
  
  // Check if all required environment variables are set
  static List<String> getMissingConfig() {
    final missing = <String>[];
    if (appwriteEndpoint.isEmpty) missing.add('APPWRITE_ENDPOINT');
    if (appwriteProjectId.isEmpty) missing.add('APPWRITE_PROJECT_ID');
    if (appwriteDatabaseId.isEmpty) missing.add('APPWRITE_DATABASE_ID');
    return missing;
  }
}
