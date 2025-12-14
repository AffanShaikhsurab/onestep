import 'package:equatable/equatable.dart';

/// Entity representing a micro identity affirmation
class MicroAffirmationEntity extends Equatable {
  final String id;
  final String userId;
  final String identityId;
  final String affirmationText;
  final bool isCustom;
  final DateTime createdAt;

  const MicroAffirmationEntity({
    required this.id,
    required this.userId,
    required this.identityId,
    required this.affirmationText,
    this.isCustom = false,
    required this.createdAt,
  });

  MicroAffirmationEntity copyWith({
    String? id,
    String? userId,
    String? identityId,
    String? affirmationText,
    bool? isCustom,
    DateTime? createdAt,
  }) {
    return MicroAffirmationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      identityId: identityId ?? this.identityId,
      affirmationText: affirmationText ?? this.affirmationText,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'identity_id': identityId,
      'affirmation_text': affirmationText,
      'is_custom': isCustom,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MicroAffirmationEntity.fromJson(Map<String, dynamic> json) {
    return MicroAffirmationEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      identityId: json['identity_id'] ?? '',
      affirmationText: json['affirmation_text'] ?? '',
      isCustom: json['is_custom'] ?? false,
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
        affirmationText,
        isCustom,
        createdAt,
      ];
}
