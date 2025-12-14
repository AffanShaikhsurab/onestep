/// Identity entity representing user's identity profile
library identity_entity;

import 'package:equatable/equatable.dart';

/// Entity class for user identity data
class IdentityEntity extends Equatable {
  final String id;
  final String userId;
  final String identityLabel;
  final String identitySentence;
  final String actionProof;
  final String whenText;
  final String whereText;
  final String howText;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  const IdentityEntity({
    required this.id,
    required this.userId,
    required this.identityLabel,
    required this.identitySentence,
    required this.actionProof,
    required this.whenText,
    required this.whereText,
    required this.howText,
    required this.createdAt,
    this.lastUpdated,
  });

  IdentityEntity copyWith({
    String? id,
    String? userId,
    String? identityLabel,
    String? identitySentence,
    String? actionProof,
    String? whenText,
    String? whereText,
    String? howText,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return IdentityEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      identityLabel: identityLabel ?? this.identityLabel,
      identitySentence: identitySentence ?? this.identitySentence,
      actionProof: actionProof ?? this.actionProof,
      whenText: whenText ?? this.whenText,
      whereText: whereText ?? this.whereText,
      howText: howText ?? this.howText,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'identity_label': identityLabel,
      'identity_sentence': identitySentence,
      'action_proof': actionProof,
      'when_text': whenText,
      'where_text': whereText,
      'how_text': howText,
      'created_at': createdAt.toIso8601String(),
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }

  factory IdentityEntity.fromJson(Map<String, dynamic> json) {
    return IdentityEntity(
      id: json['id'] ?? json['\$id'] ?? '',
      userId: json['user_id'] ?? '',
      identityLabel: json['identity_label'] ?? '',
      identitySentence: json['identity_sentence'] ?? '',
      actionProof: json['action_proof'] ?? '',
      whenText: json['when_text'] ?? '',
      whereText: json['where_text'] ?? '',
      howText: json['how_text'] ?? '',
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
        identityLabel,
        identitySentence,
        actionProof,
        whenText,
        whereText,
        howText,
        createdAt,
        lastUpdated,
      ];
}
