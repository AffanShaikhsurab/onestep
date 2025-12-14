/// States for habit creation
part of 'habit_creation_bloc.dart';

/// Base class for habit creation states
abstract class HabitCreationState extends Equatable {
  const HabitCreationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class HabitCreationInitial extends HabitCreationState {
  const HabitCreationInitial();
}

/// Loading state
class HabitCreationLoading extends HabitCreationState {
  const HabitCreationLoading();
}

/// Habit creation in progress
class HabitCreationInProgress extends HabitCreationState {
  final String userId;
  final String identityId;
  final String habitName;
  final String habitDescription;
  final String cue;
  final String craving;
  final String response;
  final String reward;
  final int frequency;
  final String timeOfDay;
  final int duration;

  const HabitCreationInProgress({
    required this.userId,
    required this.identityId,
    this.habitName = '',
    this.habitDescription = '',
    this.cue = '',
    this.craving = '',
    this.response = '',
    this.reward = '',
    this.frequency = 7,
    this.timeOfDay = '',
    this.duration = 0,
  });

  bool get isValid {
    return habitName.trim().isNotEmpty &&
        cue.trim().isNotEmpty &&
        response.trim().isNotEmpty &&
        reward.trim().isNotEmpty &&
        frequency > 0 &&
        duration > 0;
  }

  HabitCreationInProgress copyWith({
    String? userId,
    String? identityId,
    String? habitName,
    String? habitDescription,
    String? cue,
    String? craving,
    String? response,
    String? reward,
    int? frequency,
    String? timeOfDay,
    int? duration,
  }) {
    return HabitCreationInProgress(
      userId: userId ?? this.userId,
      identityId: identityId ?? this.identityId,
      habitName: habitName ?? this.habitName,
      habitDescription: habitDescription ?? this.habitDescription,
      cue: cue ?? this.cue,
      craving: craving ?? this.craving,
      response: response ?? this.response,
      reward: reward ?? this.reward,
      frequency: frequency ?? this.frequency,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        identityId,
        habitName,
        habitDescription,
        cue,
        craving,
        response,
        reward,
        frequency,
        timeOfDay,
        duration,
      ];
}

/// Habit created successfully
class HabitCreationSuccess extends HabitCreationState {
  final HabitEntity habit;

  const HabitCreationSuccess(this.habit);

  @override
  List<Object?> get props => [habit];
}

/// Error state
class HabitCreationError extends HabitCreationState {
  final String message;

  const HabitCreationError(this.message);

  @override
  List<Object?> get props => [message];
}
