/// Habit creation BLoC for managing habit form
library habit_creation_bloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/entities/habit_entity.dart';
import '../data/repository/habit_repository.dart';

part 'habit_creation_event.dart';
part 'habit_creation_state.dart';

/// BLoC for managing habit creation process
class HabitCreationBloc extends Bloc<HabitCreationEvent, HabitCreationState> {
  final HabitRepository _repository;

  HabitCreationBloc(this._repository) : super(const HabitCreationInitial()) {
    on<StartHabitCreation>(_onStartHabitCreation);
    on<UpdateHabitName>(_onUpdateHabitName);
    on<UpdateHabitDescription>(_onUpdateHabitDescription);
    on<UpdateCue>(_onUpdateCue);
    on<UpdateCraving>(_onUpdateCraving);
    on<UpdateResponse>(_onUpdateResponse);
    on<UpdateReward>(_onUpdateReward);
    on<UpdateFrequency>(_onUpdateFrequency);
    on<UpdateTimeOfDay>(_onUpdateTimeOfDay);
    on<UpdateDuration>(_onUpdateDuration);
    on<SubmitHabit>(_onSubmitHabit);
  }

  void _onStartHabitCreation(StartHabitCreation event, Emitter<HabitCreationState> emit) {
    emit(HabitCreationInProgress(
      userId: event.userId,
      identityId: event.identityId,
    ));
  }

  void _onUpdateHabitName(UpdateHabitName event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(habitName: event.name));
    }
  }

  void _onUpdateHabitDescription(UpdateHabitDescription event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(habitDescription: event.description));
    }
  }

  void _onUpdateCue(UpdateCue event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(cue: event.cue));
    }
  }

  void _onUpdateCraving(UpdateCraving event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(craving: event.craving));
    }
  }

  void _onUpdateResponse(UpdateResponse event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(response: event.response));
    }
  }

  void _onUpdateReward(UpdateReward event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(reward: event.reward));
    }
  }

  void _onUpdateFrequency(UpdateFrequency event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(frequency: event.frequency));
    }
  }

  void _onUpdateTimeOfDay(UpdateTimeOfDay event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(timeOfDay: event.timeOfDay));
    }
  }

  void _onUpdateDuration(UpdateDuration event, Emitter<HabitCreationState> emit) {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;
      emit(current.copyWith(duration: event.duration));
    }
  }

  Future<void> _onSubmitHabit(SubmitHabit event, Emitter<HabitCreationState> emit) async {
    if (state is HabitCreationInProgress) {
      final current = state as HabitCreationInProgress;

      if (!current.isValid) {
        emit(const HabitCreationError('Please fill in all required fields'));
        return;
      }

      emit(const HabitCreationLoading());

      try {
        final habit = HabitEntity(
          id: '',
          userId: current.userId,
          identityId: current.identityId,
          habitName: current.habitName,
          habitDescription: current.habitDescription,
          cue: current.cue,
          craving: current.craving,
          response: current.response,
          reward: current.reward,
          frequency: current.frequency,
          timeOfDay: current.timeOfDay,
          duration: current.duration,
          createdAt: DateTime.now(),
        );

        final createdHabit = await _repository.createHabit(habit);
        emit(HabitCreationSuccess(createdHabit));
      } catch (e) {
        emit(HabitCreationError('Failed to create habit: $e'));
      }
    }
  }
}
