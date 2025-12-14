/// Application configuration and environment variables management
library app_config;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // Appwrite Configuration - loaded from environment
  static String get appwriteEndpoint => 
      dotenv.env['APPWRITE_ENDPOINT'] ?? '';
  
  static String get appwriteProjectId => 
      dotenv.env['APPWRITE_PROJECT_ID'] ?? '';
  
  static String get appwriteDatabaseId => 
      dotenv.env['APPWRITE_DATABASE_ID'] ?? '';
  
  static String get appwriteApiKey => 
      dotenv.env['APPWRITE_API_KEY'] ?? '';
  
  // OAuth2 Configuration
  static const String appwriteCallbackScheme = 'onestep';
  
  // Gemini AI Configuration
  static String get geminiApiKey => 
      dotenv.env['GEMINI_API_KEY'] ?? '';
  
  // App Configuration
  static String get appName => 
      dotenv.env['APP_NAME'] ?? 'OneStep';
  
  static String get appVersion => 
      dotenv.env['APP_VERSION'] ?? '1.0.0';
  
  static bool get debugMode => 
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  
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
