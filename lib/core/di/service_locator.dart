/// Service locator for dependency injection
library service_locator;

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';

import '../interfaces/local_storage_interface.dart';
import '../services/local_storage_service.dart';
import '../services/database_service.dart';
import '../services/ai_service.dart';
import '../services/appwrite_service.dart';
import '../services/auth_service.dart';
import '../services/cache_manager_service.dart';
import '../env/app_config.dart';

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Service locator for managing app-wide dependencies
class ServiceLocator {
  /// Initialize all services and dependencies
  static Future<void> init() async {
    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    
    // Database service
    sl.registerLazySingleton<DatabaseService>(() => DatabaseService());
    await sl<DatabaseService>().init();
    
    // Storage services
    sl.registerLazySingleton<ILocalStorageService>(
      () => LocalStorageService(sl<SharedPreferences>()),
    );
    
    // Appwrite services
    sl.registerLazySingleton<AppwriteService>(() => AppwriteService());
    
    // Register Appwrite Client and sub-services
    sl.registerLazySingleton<Client>(() => Client()
        .setEndpoint(AppConfig.appwriteEndpoint)
        .setProject(AppConfig.appwriteProjectId));
    
    sl.registerLazySingleton<Account>(() => Account(sl<Client>()));
    sl.registerLazySingleton<Databases>(() => Databases(sl<Client>()));
    sl.registerLazySingleton<Storage>(() => Storage(sl<Client>()));
    
    // Auth service
    sl.registerLazySingleton<AuthService>(() => AuthService());
    
    // AI service
    sl.registerLazySingleton<AIService>(() => AIService());
    await sl<AIService>().init();
    
    // Cache manager
    sl.registerLazySingleton<CacheManagerService>(
      () => CacheManagerService(sl<SharedPreferences>()),
    );
  }
  
  /// Reset all services (useful for testing)
  static Future<void> reset() async {
    await sl.reset();
  }
  
  /// Check if a service is registered
  static bool isRegistered<T extends Object>() {
    return sl.isRegistered<T>();
  }
}
