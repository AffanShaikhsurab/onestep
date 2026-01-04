/// Application configuration and environment variables management
library app_config;

class AppConfig {
  // Appwrite Configuration - loaded via --dart-define at build time
  static const String appwriteEndpoint = 
      String.fromEnvironment('APPWRITE_ENDPOINT', defaultValue: '');
  
  static const String appwriteProjectId = 
      String.fromEnvironment('APPWRITE_PROJECT_ID', defaultValue: '');
  
  static const String appwriteDatabaseId = 
      String.fromEnvironment('APPWRITE_DATABASE_ID', defaultValue: '');
  
  static const String appwriteApiKey = 
      String.fromEnvironment('APPWRITE_API_KEY', defaultValue: '');
  
  // OAuth2 Configuration
  static const String appwriteCallbackScheme = 'onestep';
  
  // Gemini AI Configuration
  static const String geminiApiKey = 
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  
  // App Configuration
  static const String appName = 
      String.fromEnvironment('APP_NAME', defaultValue: 'OneStep');
  
  static const String appVersion = 
      String.fromEnvironment('APP_VERSION', defaultValue: '1.0.0');
  
  static const bool debugMode = 
      String.fromEnvironment('DEBUG_MODE', defaultValue: 'false') == 'true';
  
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

