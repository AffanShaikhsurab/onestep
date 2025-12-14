import 'package:appwrite/appwrite.dart';

import '../../../../core/constants/database_constants.dart';
import '../../../../core/services/appwrite_service.dart';
import '../entities/habit_completion_entity.dart';
import 'habit_tracking_repository.dart';

/// Appwrite implementation of HabitTrackingRepository
class HabitTrackingRepositoryImpl implements HabitTrackingRepository {
  final AppwriteService _appwriteService;

  HabitTrackingRepositoryImpl(this._appwriteService);

  Databases get _databases => _appwriteService.databases;

  @override
  Future<HabitCompletionEntity> logCompletion(HabitCompletionEntity completion) async {
    try {
      final response = await _databases.createDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.completionsCollectionId,
        documentId: ID.unique(),
        data: completion.toJson(),
      );

      return HabitCompletionEntity.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to log completion: $e');
    }
  }

  @override
  Future<List<HabitCompletionEntity>> getCompletions(String habitId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.completionsCollectionId,
        queries: [
          Query.equal('habit_id', habitId),
          Query.orderDesc('completed_at'),
        ],
      );

      return response.documents
          .map((doc) => HabitCompletionEntity.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get completions: $e');
    }
  }

  @override
  Future<List<HabitCompletionEntity>> getCompletionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.completionsCollectionId,
        queries: [
          Query.equal('user_id', userId),
          Query.greaterThanEqual('completed_at', startDate.toIso8601String()),
          Query.lessThanEqual('completed_at', endDate.toIso8601String()),
          Query.orderDesc('completed_at'),
        ],
      );

      return response.documents
          .map((doc) => HabitCompletionEntity.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get completions by date range: $e');
    }
  }

  @override
  Future<void> deleteCompletion(String completionId) async {
    try {
      await _databases.deleteDocument(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.completionsCollectionId,
        documentId: completionId,
      );
    } catch (e) {
      throw Exception('Failed to delete completion: $e');
    }
  }

  @override
  Future<int> getStreak(String habitId) async {
    try {
      final completions = await getCompletions(habitId);
      
      if (completions.isEmpty) return 0;

      // Sort by date (most recent first)
      completions.sort((a, b) => b.completedAt.compareTo(a.completedAt));

      int streak = 0;
      DateTime checkDate = DateTime.now();
      final today = DateTime(checkDate.year, checkDate.month, checkDate.day);

      for (final completion in completions) {
        final completionDate = DateTime(
          completion.completedAt.year,
          completion.completedAt.month,
          completion.completedAt.day,
        );

        // Check if this completion is for the expected date
        if (completionDate.difference(today).inDays.abs() == streak) {
          streak++;
        } else {
          break;
        }
      }

      return streak;
    } catch (e) {
      throw Exception('Failed to get streak: $e');
    }
  }

  @override
  Future<bool> isCompletedOnDate(String habitId, DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final response = await _databases.listDocuments(
        databaseId: DatabaseConstants.mainDatabaseId,
        collectionId: DatabaseConstants.completionsCollectionId,
        queries: [
          Query.equal('habit_id', habitId),
          Query.greaterThanEqual('completed_at', startOfDay.toIso8601String()),
          Query.lessThan('completed_at', endOfDay.toIso8601String()),
          Query.limit(1),
        ],
      );

      return response.documents.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
