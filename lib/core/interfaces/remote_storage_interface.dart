/// Interface for remote storage operations with Appwrite
library remote_storage_interface;

abstract class IRemoteStorageService {
  // Authentication
  Future<Map<String, dynamic>?> getCurrentUser();
  Future<Map<String, dynamic>> signUp(String email, String password, String name);
  Future<Map<String, dynamic>> signIn(String email, String password);
  Future<void> signOut();
  
  // Database operations
  Future<Map<String, dynamic>> createDocument(
    String collectionId,
    Map<String, dynamic> data, {
    String? documentId,
  });
  
  Future<Map<String, dynamic>> getDocument(
    String collectionId,
    String documentId,
  );
  
  Future<List<Map<String, dynamic>>> listDocuments(
    String collectionId, {
    List<String>? queries,
  });
  
  Future<Map<String, dynamic>> updateDocument(
    String collectionId,
    String documentId,
    Map<String, dynamic> data,
  );
  
  Future<void> deleteDocument(
    String collectionId,
    String documentId,
  );
  
  // File storage
  Future<String> uploadFile(String filePath, String fileName);
  Future<void> deleteFile(String fileId);
  String getFileUrl(String fileId);
}
