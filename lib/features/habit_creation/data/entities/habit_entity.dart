import 'package:equatable/equatable.dart';

/// Entity representing a habit
class HabitEntity extends Equatable {
  final String id;
  final String userId;
  final String identityId;
  final String habitName;
  final String habitDescription;
  final String cue;
  final String craving;
  final String response;
  final String reward;
  final int frequency; // days per week
  final String timeOfDay;
  final int duration; // in minutes
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  const HabitEntity({
    required this.id,
    required this.userId,
    required this.identityId,
    required this.habitName,
    required this.habitDescription,
    required this.cue,
    required this.craving,
    required this.response,
    required this.reward,
    required this.frequency,
    required this.timeOfDay,
    required this.duration,
    this.isActive = true,
    required this.createdAt,
    this.lastUpdated,
  });

  HabitEntity copyWith({
    String? id,
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
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return HabitEntity(
      id: id ?? this.id,
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
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'identity_id': identityId,
      'habit_name': habitName,
      'habit_description': habitDescription,
      'cue': cue,
      'craving': craving,
      'response': response,
      'reward': reward,
      'frequency': frequency,
      'time_of_day': timeOfDay,
      'duration': duration,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }

  factory HabitEntity.fromJson(Map<String, dynamic> json) {
    return HabitEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      identityId: json['identity_id'] ?? '',
      habitName: json['habit_name'] ?? '',
      habitDescription: json['habit_description'] ?? '',
      cue: json['cue'] ?? '',
      craving: json['craving'] ?? '',
      response: json['response'] ?? '',
      reward: json['reward'] ?? '',
      frequency: json['frequency'] ?? 7,
      timeOfDay: json['time_of_day'] ?? '',
      duration: json['duration'] ?? 0,
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
        isActive,
        createdAt,
        lastUpdated,
      ];
}
