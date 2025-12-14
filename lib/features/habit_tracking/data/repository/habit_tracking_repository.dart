import '../entities/habit_completion_entity.dart';

/// Repository interface for habit tracking operations
abstract class HabitTrackingRepository {
  /// Log a habit completion
  Future<HabitCompletionEntity> logCompletion(HabitCompletionEntity completion);

  /// Get all completions for a habit
  Future<List<HabitCompletionEntity>> getCompletions(String habitId);

  /// Get completions for a date range
  Future<List<HabitCompletionEntity>> getCompletionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Delete a completion
  Future<void> deleteCompletion(String completionId);

  /// Get streak for a habit
  Future<int> getStreak(String habitId);

  /// Check if habit was completed on a specific date
  Future<bool> isCompletedOnDate(String habitId, DateTime date);
}
