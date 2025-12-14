/// Identity repository implementation using Appwrite
library identity_repository_impl;

import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/database_constants.dart';
import '../entities/identity_entity.dart';
import 'identity_repository.dart';

/// Implementation of identity repository using Appwrite
class IdentityRepositoryImpl implements IdentityRepository {
  final Databases _databases;

  IdentityRepositoryImpl(this._databases);

  @override
  Future<IdentityEntity> createIdentity(IdentityEntity identity) async {
    try {
      final document = await _databases.createDocument(
        databaseId: DatabaseConstants.databaseId,
        collectionId: DatabaseConstants.identitiesCollection,
        documentId: ID.unique(),
        data: identity.toJson(),
      );
      
      return IdentityEntity.fromJson(document.data);
    } catch (e) {
      throw Exception('Failed to create identity: $e');
    }
  }

  @override
  Future<List<IdentityEntity>> getAllIdentities(String userId) async {
    try {
      final documents = await _databases.listDocuments(
        databaseId: DatabaseConstants.databaseId,
        collectionId: DatabaseConstants.identitiesCollection,
        queries: [
          Query.equal('user_id', userId),
        ],
      );
      
      return documents.documents
          .map((doc) => IdentityEntity.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get identities: $e');
    }
  }

  @override
  Future<IdentityEntity?> getIdentityById(String id) async {
    try {
      final document = await _databases.getDocument(
        databaseId: DatabaseConstants.databaseId,
        collectionId: DatabaseConstants.identitiesCollection,
        documentId: id,
      );
      
      return IdentityEntity.fromJson(document.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<IdentityEntity> updateIdentity(IdentityEntity identity) async {
    try {
      final document = await _databases.updateDocument(
        databaseId: DatabaseConstants.databaseId,
        collectionId: DatabaseConstants.identitiesCollection,
        documentId: identity.id,
        data: identity.toJson(),
      );
      
      return IdentityEntity.fromJson(document.data);
    } catch (e) {
      throw Exception('Failed to update identity: $e');
    }
  }

  @override
  Future<void> deleteIdentity(String id) async {
    try {
      await _databases.deleteDocument(
        databaseId: DatabaseConstants.databaseId,
        collectionId: DatabaseConstants.identitiesCollection,
        documentId: id,
      );
    } catch (e) {
      throw Exception('Failed to delete identity: $e');
    }
  }
}
