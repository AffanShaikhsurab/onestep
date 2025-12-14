import 'package:equatable/equatable.dart';

/// Entity representing a habit stack (sequence of habits)
class HabitStackEntity extends Equatable {
  final String id;
  final String userId;
  final String stackName;
  final List<String> habitIds; // Ordered list of habit IDs
  final String? triggerHabitId; // Optional trigger habit
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  const HabitStackEntity({
    required this.id,
    required this.userId,
    required this.stackName,
    required this.habitIds,
    this.triggerHabitId,
    this.isActive = true,
    required this.createdAt,
    this.lastUpdated,
  });

  HabitStackEntity copyWith({
    String? id,
    String? userId,
    String? stackName,
    List<String>? habitIds,
    String? triggerHabitId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return HabitStackEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      stackName: stackName ?? this.stackName,
      habitIds: habitIds ?? this.habitIds,
      triggerHabitId: triggerHabitId ?? this.triggerHabitId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'stack_name': stackName,
      'habit_ids': habitIds,
      'trigger_habit_id': triggerHabitId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }

  factory HabitStackEntity.fromJson(Map<String, dynamic> json) {
    return HabitStackEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      stackName: json['stack_name'] ?? '',
      habitIds: json['habit_ids'] != null
          ? List<String>.from(json['habit_ids'])
          : [],
      triggerHabitId: json['trigger_habit_id'],
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
        stackName,
        habitIds,
        triggerHabitId,
        isActive,
        createdAt,
        lastUpdated,
      ];
}
