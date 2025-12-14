import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:onestep/features/habit_creation/data/entities/habit_entity.dart';
import 'package:onestep/features/habit_creation/state/habit_creation_bloc.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockHabitRepository mockRepository;

  setUp(() {
    mockRepository = MockHabitRepository();
  });

  group('HabitCreationBloc', () {
    final testDateTime = DateTime(2024, 1, 15, 10, 30);
    
    final testHabit = HabitEntity(
      id: 'habit-123',
      userId: 'user-456',
      identityId: 'identity-789',
      habitName: 'Morning Run',
      habitDescription: 'Run 5km every morning',
      cue: 'Wake up alarm',
      craving: 'Feel energized',
      response: 'Put on running shoes',
      reward: 'Healthy breakfast',
      frequency: 5,
      timeOfDay: 'morning',
      duration: 30,
      createdAt: testDateTime,
    );

    group('StartHabitCreation', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'emits [InProgress] with userId and identityId',
        build: () => HabitCreationBloc(mockRepository),
        act: (bloc) => bloc.add(const StartHabitCreation(
          userId: 'user-456',
          identityId: 'identity-789',
        )),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.userId, 'userId', 'user-456')
              .having((s) => s.identityId, 'identityId', 'identity-789'),
        ],
      );
    });

    group('UpdateHabitName', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates habit name in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateHabitName('Morning Run')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.habitName, 'habitName', 'Morning Run'),
        ],
      );

      blocTest<HabitCreationBloc, HabitCreationState>(
        'does nothing when not in progress state',
        build: () => HabitCreationBloc(mockRepository),
        act: (bloc) => bloc.add(const UpdateHabitName('Morning Run')),
        expect: () => [],
      );
    });

    group('UpdateHabitDescription', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates habit description in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateHabitDescription('Run 5km every morning')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.habitDescription, 'habitDescription', 'Run 5km every morning'),
        ],
      );
    });

    group('UpdateCue', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates cue in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateCue('Wake up alarm')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.cue, 'cue', 'Wake up alarm'),
        ],
      );
    });

    group('UpdateCraving', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates craving in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateCraving('Feel energized')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.craving, 'craving', 'Feel energized'),
        ],
      );
    });

    group('UpdateResponse', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates response in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateResponse('Put on running shoes')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.response, 'response', 'Put on running shoes'),
        ],
      );
    });

    group('UpdateReward', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates reward in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateReward('Healthy breakfast')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.reward, 'reward', 'Healthy breakfast'),
        ],
      );
    });

    group('UpdateFrequency', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates frequency in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateFrequency(5)),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.frequency, 'frequency', 5),
        ],
      );
    });

    group('UpdateTimeOfDay', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates time of day in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateTimeOfDay('morning')),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.timeOfDay, 'timeOfDay', 'morning'),
        ],
      );
    });

    group('UpdateDuration', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'updates duration in progress state',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
        ),
        act: (bloc) => bloc.add(const UpdateDuration(30)),
        expect: () => [
          isA<HabitCreationInProgress>()
              .having((s) => s.duration, 'duration', 30),
        ],
      );
    });

    group('SubmitHabit', () {
      blocTest<HabitCreationBloc, HabitCreationState>(
        'emits [Loading, Success] on successful submission',
        setUp: () {
          when(mockRepository.createHabit(any))
              .thenAnswer((_) async => testHabit);
        },
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: 'Morning Run',
          habitDescription: 'Run 5km every morning',
          cue: 'Wake up alarm',
          craving: 'Feel energized',
          response: 'Put on running shoes',
          reward: 'Healthy breakfast',
          frequency: 5,
          timeOfDay: 'morning',
          duration: 30,
        ),
        act: (bloc) => bloc.add(SubmitHabit()),
        expect: () => [
          isA<HabitCreationLoading>(),
          isA<HabitCreationSuccess>()
              .having((s) => s.habit.habitName, 'habitName', 'Morning Run'),
        ],
        verify: (_) {
          verify(mockRepository.createHabit(any)).called(1);
        },
      );

      blocTest<HabitCreationBloc, HabitCreationState>(
        'emits [Error] when form is not valid (missing required fields)',
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: '', // Empty required field
        ),
        act: (bloc) => bloc.add(SubmitHabit()),
        expect: () => [
          isA<HabitCreationError>()
              .having((s) => s.message, 'message', contains('required fields')),
        ],
      );

      blocTest<HabitCreationBloc, HabitCreationState>(
        'emits [Loading, Error] when repository throws',
        setUp: () {
          when(mockRepository.createHabit(any))
              .thenThrow(Exception('Database error'));
        },
        build: () => HabitCreationBloc(mockRepository),
        seed: () => const HabitCreationInProgress(
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: 'Morning Run',
          habitDescription: 'Run 5km every morning',
          cue: 'Wake up alarm',
          craving: 'Feel energized',
          response: 'Put on running shoes',
          reward: 'Healthy breakfast',
          frequency: 5,
          timeOfDay: 'morning',
          duration: 30,
        ),
        act: (bloc) => bloc.add(SubmitHabit()),
        expect: () => [
          isA<HabitCreationLoading>(),
          isA<HabitCreationError>()
              .having((s) => s.message, 'message', contains('Failed to create habit')),
        ],
      );

      blocTest<HabitCreationBloc, HabitCreationState>(
        'does nothing when not in progress state',
        build: () => HabitCreationBloc(mockRepository),
        act: (bloc) => bloc.add(SubmitHabit()),
        expect: () => [],
      );
    });
  });
}
