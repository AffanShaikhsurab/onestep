/// Habit Creation Feature
/// 
/// Manages the creation of new habits based on the Habit Loop framework:
/// - Cue (What triggers the habit)
/// - Craving (Why you want to do it)
/// - Response (The action itself)
/// - Reward (The benefit you get)
library habit_creation;

// Data Layer
export 'data/entities/habit_entity.dart';
export 'data/repository/habit_repository.dart';
export 'data/repository/habit_repository_impl.dart';

// State Management
export 'state/habit_creation_bloc.dart';

// UI Layer
export 'ui/habit_creation_screen.dart';
