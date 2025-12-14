import 'package:equatable/equatable.dart';

/// Entity representing a habit completion record
class HabitCompletionEntity extends Equatable {
  final String id;
  final String habitId;
  final String userId;
  final DateTime completedAt;
  final String? notes;
  final int? rating; // 1-5 satisfaction rating
  final DateTime createdAt;

  const HabitCompletionEntity({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.completedAt,
    this.notes,
    this.rating,
    required this.createdAt,
  });

  HabitCompletionEntity copyWith({
    String? id,
    String? habitId,
    String? userId,
    DateTime? completedAt,
    String? notes,
    int? rating,
    DateTime? createdAt,
  }) {
    return HabitCompletionEntity(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'user_id': userId,
      'completed_at': completedAt.toIso8601String(),
      'notes': notes,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory HabitCompletionEntity.fromJson(Map<String, dynamic> json) {
    return HabitCompletionEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      habitId: json['habit_id'] ?? '',
      userId: json['user_id'] ?? '',
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : DateTime.now(),
      notes: json['notes'],
      rating: json['rating'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        habitId,
        userId,
        completedAt,
        notes,
        rating,
        createdAt,
      ];
}
