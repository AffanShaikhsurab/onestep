import '../entities/habit_stack_entity.dart';

/// Repository interface for habit stacking operations
abstract class HabitStackingRepository {
  /// Create a new habit stack
  Future<HabitStackEntity> createStack(HabitStackEntity stack);

  /// Get all stacks for a user
  Future<List<HabitStackEntity>> getAllStacks(String userId);

  /// Get a specific stack by ID
  Future<HabitStackEntity> getStackById(String stackId);

  /// Update a stack
  Future<HabitStackEntity> updateStack(HabitStackEntity stack);

  /// Delete a stack
  Future<void> deleteStack(String stackId);

  /// Reorder habits in a stack
  Future<HabitStackEntity> reorderHabits(String stackId, List<String> newOrder);
}
