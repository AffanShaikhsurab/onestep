import '../entities/habit_entity.dart';

/// Repository interface for habit operations
abstract class HabitRepository {
  /// Create a new habit
  Future<HabitEntity> createHabit(HabitEntity habit);

  /// Get all habits for a user
  Future<List<HabitEntity>> getAllHabits(String userId);

  /// Get habits by identity
  Future<List<HabitEntity>> getHabitsByIdentity(String identityId);

  /// Get a specific habit by ID
  Future<HabitEntity> getHabitById(String habitId);

  /// Update an existing habit
  Future<HabitEntity> updateHabit(HabitEntity habit);

  /// Delete a habit
  Future<void> deleteHabit(String habitId);

  /// Toggle habit active status
  Future<void> toggleHabitStatus(String habitId, bool isActive);
}
