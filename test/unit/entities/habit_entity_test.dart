import 'package:flutter_test/flutter_test.dart';
import 'package:onestep/features/habit_creation/data/entities/habit_entity.dart';

void main() {
  group('HabitEntity', () {
    final testDateTime = DateTime(2024, 1, 15, 10, 30);
    final testLastUpdated = DateTime(2024, 1, 16, 12, 0);

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
      isActive: true,
      createdAt: testDateTime,
      lastUpdated: testLastUpdated,
    );

    group('toJson', () {
      test('serializes all fields correctly', () {
        final json = testHabit.toJson();

        expect(json['id'], equals('habit-123'));
        expect(json['user_id'], equals('user-456'));
        expect(json['identity_id'], equals('identity-789'));
        expect(json['habit_name'], equals('Morning Run'));
        expect(json['habit_description'], equals('Run 5km every morning'));
        expect(json['cue'], equals('Wake up alarm'));
        expect(json['craving'], equals('Feel energized'));
        expect(json['response'], equals('Put on running shoes'));
        expect(json['reward'], equals('Healthy breakfast'));
        expect(json['frequency'], equals(5));
        expect(json['time_of_day'], equals('morning'));
        expect(json['duration'], equals(30));
        expect(json['is_active'], equals(true));
        expect(json['created_at'], equals(testDateTime.toIso8601String()));
        expect(json['last_updated'], equals(testLastUpdated.toIso8601String()));
      });

      test('handles null lastUpdated', () {
        final habitWithoutUpdate = HabitEntity(
          id: 'habit-123',
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: 'Test Habit',
          habitDescription: 'Description',
          cue: 'Cue',
          craving: 'Craving',
          response: 'Response',
          reward: 'Reward',
          frequency: 7,
          timeOfDay: 'evening',
          duration: 15,
          createdAt: testDateTime,
        );

        final json = habitWithoutUpdate.toJson();
        expect(json['last_updated'], isNull);
      });
    });

    group('fromJson', () {
      test('deserializes all fields correctly', () {
        final json = {
          'id': 'habit-123',
          'user_id': 'user-456',
          'identity_id': 'identity-789',
          'habit_name': 'Morning Run',
          'habit_description': 'Run 5km every morning',
          'cue': 'Wake up alarm',
          'craving': 'Feel energized',
          'response': 'Put on running shoes',
          'reward': 'Healthy breakfast',
          'frequency': 5,
          'time_of_day': 'morning',
          'duration': 30,
          'is_active': true,
          'created_at': testDateTime.toIso8601String(),
          'last_updated': testLastUpdated.toIso8601String(),
        };

        final habit = HabitEntity.fromJson(json);

        expect(habit.id, equals('habit-123'));
        expect(habit.userId, equals('user-456'));
        expect(habit.identityId, equals('identity-789'));
        expect(habit.habitName, equals('Morning Run'));
        expect(habit.habitDescription, equals('Run 5km every morning'));
        expect(habit.cue, equals('Wake up alarm'));
        expect(habit.craving, equals('Feel energized'));
        expect(habit.response, equals('Put on running shoes'));
        expect(habit.reward, equals('Healthy breakfast'));
        expect(habit.frequency, equals(5));
        expect(habit.timeOfDay, equals('morning'));
        expect(habit.duration, equals(30));
        expect(habit.isActive, equals(true));
        expect(habit.createdAt, equals(testDateTime));
        expect(habit.lastUpdated, equals(testLastUpdated));
      });

      test('handles Appwrite \$id field', () {
        final json = {
          '\$id': 'appwrite-id-123',
          'user_id': 'user-456',
          'identity_id': 'identity-789',
          'habit_name': 'Test',
          'habit_description': 'Desc',
          'cue': 'Cue',
          'craving': 'Craving',
          'response': 'Response',
          'reward': 'Reward',
          'frequency': 7,
          'time_of_day': 'morning',
          'duration': 15,
          'created_at': testDateTime.toIso8601String(),
        };

        final habit = HabitEntity.fromJson(json);
        expect(habit.id, equals('appwrite-id-123'));
      });

      test('handles missing optional fields with defaults', () {
        final json = <String, dynamic>{
          'id': 'habit-123',
          'created_at': testDateTime.toIso8601String(),
        };

        final habit = HabitEntity.fromJson(json);

        expect(habit.userId, equals(''));
        expect(habit.frequency, equals(7)); // default value
        expect(habit.isActive, equals(true)); // default value
        expect(habit.lastUpdated, isNull);
      });

      test('handles null created_at with current time', () {
        final json = <String, dynamic>{
          'id': 'habit-123',
        };

        final beforeTest = DateTime.now();
        final habit = HabitEntity.fromJson(json);
        final afterTest = DateTime.now();

        expect(habit.createdAt.isAfter(beforeTest.subtract(const Duration(seconds: 1))), isTrue);
        expect(habit.createdAt.isBefore(afterTest.add(const Duration(seconds: 1))), isTrue);
      });
    });

    group('copyWith', () {
      test('creates new instance with modified fields', () {
        final updatedHabit = testHabit.copyWith(
          habitName: 'Evening Walk',
          duration: 45,
        );

        expect(updatedHabit.habitName, equals('Evening Walk'));
        expect(updatedHabit.duration, equals(45));
        // Unchanged fields remain the same
        expect(updatedHabit.id, equals(testHabit.id));
        expect(updatedHabit.userId, equals(testHabit.userId));
        expect(updatedHabit.cue, equals(testHabit.cue));
      });

      test('returns new instance (immutability)', () {
        final updatedHabit = testHabit.copyWith(habitName: 'New Name');

        expect(updatedHabit, isNot(same(testHabit)));
        expect(testHabit.habitName, equals('Morning Run')); // Original unchanged
      });

      test('allows updating all fields', () {
        final newDateTime = DateTime(2025, 6, 1);
        final updated = testHabit.copyWith(
          id: 'new-id',
          userId: 'new-user',
          identityId: 'new-identity',
          habitName: 'New Name',
          habitDescription: 'New Desc',
          cue: 'New Cue',
          craving: 'New Craving',
          response: 'New Response',
          reward: 'New Reward',
          frequency: 3,
          timeOfDay: 'night',
          duration: 60,
          isActive: false,
          createdAt: newDateTime,
          lastUpdated: newDateTime,
        );

        expect(updated.id, equals('new-id'));
        expect(updated.userId, equals('new-user'));
        expect(updated.identityId, equals('new-identity'));
        expect(updated.isActive, equals(false));
      });
    });

    group('Equatable', () {
      test('two entities with same props are equal', () {
        final habit1 = HabitEntity(
          id: 'habit-123',
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: 'Test',
          habitDescription: 'Desc',
          cue: 'Cue',
          craving: 'Craving',
          response: 'Response',
          reward: 'Reward',
          frequency: 7,
          timeOfDay: 'morning',
          duration: 30,
          createdAt: testDateTime,
        );

        final habit2 = HabitEntity(
          id: 'habit-123',
          userId: 'user-456',
          identityId: 'identity-789',
          habitName: 'Test',
          habitDescription: 'Desc',
          cue: 'Cue',
          craving: 'Craving',
          response: 'Response',
          reward: 'Reward',
          frequency: 7,
          timeOfDay: 'morning',
          duration: 30,
          createdAt: testDateTime,
        );

        expect(habit1, equals(habit2));
        expect(habit1.hashCode, equals(habit2.hashCode));
      });

      test('two entities with different props are not equal', () {
        final habit1 = testHabit;
        final habit2 = testHabit.copyWith(habitName: 'Different Name');

        expect(habit1, isNot(equals(habit2)));
      });
    });

    group('round-trip serialization', () {
      test('toJson then fromJson produces equal entity', () {
        final json = testHabit.toJson();
        final restored = HabitEntity.fromJson(json);

        expect(restored, equals(testHabit));
      });
    });
  });
}
