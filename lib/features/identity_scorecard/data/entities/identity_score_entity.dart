import 'package:equatable/equatable.dart';

/// Entity representing identity score and progress
class IdentityScoreEntity extends Equatable {
  final String id;
  final String userId;
  final String identityId;
  final int totalScore;
  final int consistencyScore;
  final int frequencyScore;
  final int qualityScore;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastUpdated;

  const IdentityScoreEntity({
    required this.id,
    required this.userId,
    required this.identityId,
    required this.totalScore,
    required this.consistencyScore,
    required this.frequencyScore,
    required this.qualityScore,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastUpdated,
  });

  IdentityScoreEntity copyWith({
    String? id,
    String? userId,
    String? identityId,
    int? totalScore,
    int? consistencyScore,
    int? frequencyScore,
    int? qualityScore,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastUpdated,
  }) {
    return IdentityScoreEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      identityId: identityId ?? this.identityId,
      totalScore: totalScore ?? this.totalScore,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      frequencyScore: frequencyScore ?? this.frequencyScore,
      qualityScore: qualityScore ?? this.qualityScore,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'identity_id': identityId,
      'total_score': totalScore,
      'consistency_score': consistencyScore,
      'frequency_score': frequencyScore,
      'quality_score': qualityScore,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  factory IdentityScoreEntity.fromJson(Map<String, dynamic> json) {
    return IdentityScoreEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      identityId: json['identity_id'] ?? '',
      totalScore: json['total_score'] ?? 0,
      consistencyScore: json['consistency_score'] ?? 0,
      frequencyScore: json['frequency_score'] ?? 0,
      qualityScore: json['quality_score'] ?? 0,
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        identityId,
        totalScore,
        consistencyScore,
        frequencyScore,
        qualityScore,
        currentStreak,
        longestStreak,
        lastUpdated,
      ];
}
