import '../entities/identity_score_entity.dart';

/// Repository interface for identity scorecard operations
abstract class IdentityScorecardRepository {
  /// Get identity score for a user
  Future<IdentityScoreEntity> getIdentityScore(String userId, String identityId);

  /// Update identity score
  Future<IdentityScoreEntity> updateScore(IdentityScoreEntity score);

  /// Calculate and update scores based on habit completions
  Future<IdentityScoreEntity> recalculateScore(String userId, String identityId);
}
