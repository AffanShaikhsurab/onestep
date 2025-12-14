/// Authentication service using Appwrite Account API
library auth_service;

import 'package:appwrite/appwrite.dart';

import '../env/app_config.dart';

/// Service for handling user authentication
class AuthService {
  late Client _client;
  late Account _account;

  AuthService() {
    _initializeClient();
  }
  
  void _initializeClient() {
    _client = Client()
        .setEndpoint(AppConfig.appwriteEndpoint)
        .setProject(AppConfig.appwriteProjectId);
    
    _account = Account(_client);
  }

  /// Get current authenticated user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user.toMap();
    } catch (e) {
      return null;
    }
  }

  /// Create a new user account
  Future<Map<String, dynamic>> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user.toMap();
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  /// Sign in with email and password
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session.toMap();
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  /// Create anonymous session
  Future<Map<String, dynamic>> createAnonymousSession() async {
    try {
      final session = await _account.createAnonymousSession();
      return session.toMap();
    } catch (e) {
      throw Exception('Failed to create anonymous session: $e');
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      final user = await _account.get();
      return user.$id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get current session
  Future<Map<String, dynamic>?> getCurrentSession() async {
    try {
      final session = await _account.getSession(sessionId: 'current');
      return session.toMap();
    } catch (e) {
      return null;
    }
  }

  /// Update user name
  Future<Map<String, dynamic>> updateName(String name) async {
    try {
      final user = await _account.updateName(name: name);
      return user.toMap();
    } catch (e) {
      throw Exception('Failed to update name: $e');
    }
  }

  /// Update user email
  Future<Map<String, dynamic>> updateEmail(String email, String password) async {
    try {
      final user = await _account.updateEmail(
        email: email,
        password: password,
      );
      return user.toMap();
    } catch (e) {
      throw Exception('Failed to update email: $e');
    }
  }

  /// Update user password
  Future<Map<String, dynamic>> updatePassword(
    String newPassword,
    String oldPassword,
  ) async {
    try {
      final user = await _account.updatePassword(
        password: newPassword,
        oldPassword: oldPassword,
      );
      return user.toMap();
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }

  /// Create password recovery
  Future<Map<String, dynamic>> createPasswordRecovery(
    String email,
    String url,
  ) async {
    try {
      final token = await _account.createRecovery(
        email: email,
        url: url,
      );
      return token.toMap();
    } catch (e) {
      throw Exception('Failed to create password recovery: $e');
    }
  }

  /// Complete password recovery
  Future<Map<String, dynamic>> completePasswordRecovery(
    String userId,
    String secret,
    String password,
  ) async {
    try {
      final token = await _account.updateRecovery(
        userId: userId,
        secret: secret,
        password: password,
      );
      return token.toMap();
    } catch (e) {
      throw Exception('Failed to complete password recovery: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    // Clean up if needed
  }
}
