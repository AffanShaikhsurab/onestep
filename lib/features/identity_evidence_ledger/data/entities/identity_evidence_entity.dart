import 'package:equatable/equatable.dart';

/// Entity representing evidence of identity-aligned actions
class IdentityEvidenceEntity extends Equatable {
  final String id;
  final String userId;
  final String identityId;
  final String habitId;
  final String evidenceText;
  final String? photoUrl;
  final DateTime recordedAt;
  final DateTime createdAt;

  const IdentityEvidenceEntity({
    required this.id,
    required this.userId,
    required this.identityId,
    required this.habitId,
    required this.evidenceText,
    this.photoUrl,
    required this.recordedAt,
    required this.createdAt,
  });

  IdentityEvidenceEntity copyWith({
    String? id,
    String? userId,
    String? identityId,
    String? habitId,
    String? evidenceText,
    String? photoUrl,
    DateTime? recordedAt,
    DateTime? createdAt,
  }) {
    return IdentityEvidenceEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      identityId: identityId ?? this.identityId,
      habitId: habitId ?? this.habitId,
      evidenceText: evidenceText ?? this.evidenceText,
      photoUrl: photoUrl ?? this.photoUrl,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'identity_id': identityId,
      'habit_id': habitId,
      'evidence_text': evidenceText,
      'photo_url': photoUrl,
      'recorded_at': recordedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory IdentityEvidenceEntity.fromJson(Map<String, dynamic> json) {
    return IdentityEvidenceEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      identityId: json['identity_id'] ?? '',
      habitId: json['habit_id'] ?? '',
      evidenceText: json['evidence_text'] ?? '',
      photoUrl: json['photo_url'],
      recordedAt: json['recorded_at'] != null
          ? DateTime.parse(json['recorded_at'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        identityId,
        habitId,
        evidenceText,
        photoUrl,
        recordedAt,
        createdAt,
      ];
}
