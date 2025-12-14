/// Events for habit creation
part of 'habit_creation_bloc.dart';

/// Base class for habit creation events
abstract class HabitCreationEvent extends Equatable {
  const HabitCreationEvent();

  @override
  List<Object?> get props => [];
}

/// Start habit creation
class StartHabitCreation extends HabitCreationEvent {
  final String userId;
  final String identityId;

  const StartHabitCreation({
    required this.userId,
    required this.identityId,
  });

  @override
  List<Object?> get props => [userId, identityId];
}

/// Update habit name
class UpdateHabitName extends HabitCreationEvent {
  final String name;

  const UpdateHabitName(this.name);

  @override
  List<Object?> get props => [name];
}

/// Update habit description
class UpdateHabitDescription extends HabitCreationEvent {
  final String description;

  const UpdateHabitDescription(this.description);

  @override
  List<Object?> get props => [description];
}

/// Update cue (trigger)
class UpdateCue extends HabitCreationEvent {
  final String cue;

  const UpdateCue(this.cue);

  @override
  List<Object?> get props => [cue];
}

/// Update craving (motivation)
class UpdateCraving extends HabitCreationEvent {
  final String craving;

  const UpdateCraving(this.craving);

  @override
  List<Object?> get props => [craving];
}

/// Update response (action)
class UpdateResponse extends HabitCreationEvent {
  final String response;

  const UpdateResponse(this.response);

  @override
  List<Object?> get props => [response];
}

/// Update reward (benefit)
class UpdateReward extends HabitCreationEvent {
  final String reward;

  const UpdateReward(this.reward);

  @override
  List<Object?> get props => [reward];
}

/// Update frequency (days per week)
class UpdateFrequency extends HabitCreationEvent {
  final int frequency;

  const UpdateFrequency(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

/// Update time of day
class UpdateTimeOfDay extends HabitCreationEvent {
  final String timeOfDay;

  const UpdateTimeOfDay(this.timeOfDay);

  @override
  List<Object?> get props => [timeOfDay];
}

/// Update duration (in minutes)
class UpdateDuration extends HabitCreationEvent {
  final int duration;

  const UpdateDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}

/// Submit habit
class SubmitHabit extends HabitCreationEvent {
  const SubmitHabit();
}
