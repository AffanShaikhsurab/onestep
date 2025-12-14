import '../entities/identity_evidence_entity.dart';

/// Repository interface for identity evidence operations
abstract class IdentityEvidenceLedgerRepository {
  /// Add new evidence
  Future<IdentityEvidenceEntity> addEvidence(IdentityEvidenceEntity evidence);

  /// Get all evidence for an identity
  Future<List<IdentityEvidenceEntity>> getEvidenceByIdentity(String identityId);

  /// Get all evidence for a user
  Future<List<IdentityEvidenceEntity>> getEvidenceByUser(String userId);

  /// Delete evidence
  Future<void> deleteEvidence(String evidenceId);
}
