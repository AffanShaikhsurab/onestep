/// Repository interface for identity management
library identity_repository;

import '../entities/identity_entity.dart';

/// Abstract repository for identity operations
abstract class IdentityRepository {
  /// Creates a new identity
  Future<IdentityEntity> createIdentity(IdentityEntity identity);
  
  /// Retrieves all identities for a user
  Future<List<IdentityEntity>> getAllIdentities(String userId);
  
  /// Retrieves a specific identity by ID
  Future<IdentityEntity?> getIdentityById(String id);
  
  /// Updates an existing identity
  Future<IdentityEntity> updateIdentity(IdentityEntity identity);
  
  /// Deletes an identity
  Future<void> deleteIdentity(String id);
}
