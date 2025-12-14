/// Centralized Appwrite service for authentication and database operations
library appwrite_service;

import 'package:appwrite/appwrite.dart';

import '../env/app_config.dart';

/// Singleton service for managing Appwrite client and services
class AppwriteService {
  late Client _client;
  late Account _account;
  late Databases _databases;
  late Storage _storage;

  static final AppwriteService _instance = AppwriteService._internal();
  
  factory AppwriteService() => _instance;
  
  AppwriteService._internal() {
    _initialize();
  }

  void _initialize() {
    _client = Client()
        .setEndpoint(AppConfig.appwriteEndpoint)
        .setProject(AppConfig.appwriteProjectId);
    
    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
  }

  /// Get Appwrite Account service
  Account get account => _account;
  
  /// Get Appwrite Databases service
  Databases get databases => _databases;
  
  /// Get Appwrite Storage service
  Storage get storage => _storage;
  
  /// Get Appwrite Client
  Client get client => _client;

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
  Future<Map<String, dynamic>> signUp(String email, String password, String name) async {
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

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      final user = await _account.get();
      return user.$id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Create a document in a collection
  Future<Map<String, dynamic>> createDocument(
    String collectionId,
    Map<String, dynamic> data, {
    String? documentId,
  }) async {
    try {
      final document = await _databases.createDocument(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: collectionId,
        documentId: documentId ?? ID.unique(),
        data: data,
      );
      return document.data;
    } catch (e) {
      throw Exception('Failed to create document: $e');
    }
  }

  /// Get a document by ID
  Future<Map<String, dynamic>> getDocument(
    String collectionId,
    String documentId,
  ) async {
    try {
      final document = await _databases.getDocument(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
      return document.data;
    } catch (e) {
      throw Exception('Failed to get document: $e');
    }
  }

  /// List documents in a collection
  Future<List<Map<String, dynamic>>> listDocuments(
    String collectionId, {
    List<String>? queries,
  }) async {
    try {
      final documents = await _databases.listDocuments(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: collectionId,
        queries: queries,
      );
      return documents.documents.map((doc) => doc.data).toList();
    } catch (e) {
      throw Exception('Failed to list documents: $e');
    }
  }

  /// Update a document
  Future<Map<String, dynamic>> updateDocument(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      final document = await _databases.updateDocument(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data,
      );
      return document.data;
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }

  /// Delete a document
  Future<void> deleteDocument(
    String collectionId,
    String documentId,
  ) async {
    try {
      await _databases.deleteDocument(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      throw Exception('Failed to delete document: $e');
    }
  }

  /// Upload a file
  Future<String> uploadFile(
    String filePath,
    String fileName, {
    String? bucketId,
  }) async {
    try {
      final file = await _storage.createFile(
        bucketId: bucketId ?? 'default',
        fileId: ID.unique(),
        file: InputFile.fromPath(path: filePath, filename: fileName),
      );
      return file.$id;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  /// Delete a file
  Future<void> deleteFile(String fileId, {String? bucketId}) async {
    try {
      await _storage.deleteFile(
        bucketId: bucketId ?? 'default',
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  /// Get file URL
  String getFileUrl(String fileId, {String? bucketId}) {
    final bucket = bucketId ?? 'default';
    return '${AppConfig.appwriteEndpoint}/storage/buckets/$bucket/files/$fileId/view?project=${AppConfig.appwriteProjectId}';
  }

  /// Generate unique ID
  String generateId() {
    return ID.unique();
  }

  /// Test connection to Appwrite
  Future<bool> testConnection() async {
    try {
      await _account.get();
      return true;
    } catch (e) {
      try {
        await _account.createAnonymousSession();
        await _account.deleteSession(sessionId: 'current');
        return true;
      } catch (e) {
        return false;
      }
    }
  }
}
