import '../entities/micro_affirmation_entity.dart';

/// Repository interface for micro affirmations operations
abstract class MicroAffirmationsRepository {
  /// Get daily affirmation
  Future<MicroAffirmationEntity> getDailyAffirmation(String userId, String identityId);

  /// Get all affirmations for an identity
  Future<List<MicroAffirmationEntity>> getAffirmationsByIdentity(String identityId);

  /// Add custom affirmation
  Future<MicroAffirmationEntity> addCustomAffirmation(MicroAffirmationEntity affirmation);

  /// Generate AI-powered affirmation
  Future<String> generateAffirmation(String identityLabel, String habitName);
}
