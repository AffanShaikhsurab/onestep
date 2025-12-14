import 'package:flutter_test/flutter_test.dart';
import 'package:onestep/features/identity_onboarding/data/entities/identity_entity.dart';

void main() {
  group('IdentityEntity', () {
    final testDateTime = DateTime(2024, 1, 15, 10, 30);
    final testLastUpdated = DateTime(2024, 1, 16, 12, 0);

    final testIdentity = IdentityEntity(
      id: 'identity-123',
      userId: 'user-456',
      identityLabel: 'Runner',
      identitySentence: 'I am a Runner',
      actionProof: 'I run 5km every morning',
      whenText: 'Every morning at 6am',
      whereText: 'At the local park',
      howText: 'By putting on my running shoes first',
      createdAt: testDateTime,
      lastUpdated: testLastUpdated,
    );

    group('toJson', () {
      test('serializes all fields correctly', () {
        final json = testIdentity.toJson();

        expect(json['id'], equals('identity-123'));
        expect(json['user_id'], equals('user-456'));
        expect(json['identity_label'], equals('Runner'));
        expect(json['identity_sentence'], equals('I am a Runner'));
        expect(json['action_proof'], equals('I run 5km every morning'));
        expect(json['when_text'], equals('Every morning at 6am'));
        expect(json['where_text'], equals('At the local park'));
        expect(json['how_text'], equals('By putting on my running shoes first'));
        expect(json['created_at'], equals(testDateTime.toIso8601String()));
        expect(json['last_updated'], equals(testLastUpdated.toIso8601String()));
      });

      test('handles null lastUpdated', () {
        final identityWithoutUpdate = IdentityEntity(
          id: 'identity-123',
          userId: 'user-456',
          identityLabel: 'Writer',
          identitySentence: 'I am a Writer',
          actionProof: 'I write daily',
          whenText: 'Morning',
          whereText: 'Home office',
          howText: 'Open laptop first',
          createdAt: testDateTime,
        );

        final json = identityWithoutUpdate.toJson();
        expect(json['last_updated'], isNull);
      });
    });

    group('fromJson', () {
      test('deserializes all fields correctly', () {
        final json = {
          'id': 'identity-123',
          'user_id': 'user-456',
          'identity_label': 'Runner',
          'identity_sentence': 'I am a Runner',
          'action_proof': 'I run 5km every morning',
          'when_text': 'Every morning at 6am',
          'where_text': 'At the local park',
          'how_text': 'By putting on my running shoes first',
          'created_at': testDateTime.toIso8601String(),
          'last_updated': testLastUpdated.toIso8601String(),
        };

        final identity = IdentityEntity.fromJson(json);

        expect(identity.id, equals('identity-123'));
        expect(identity.userId, equals('user-456'));
        expect(identity.identityLabel, equals('Runner'));
        expect(identity.identitySentence, equals('I am a Runner'));
        expect(identity.actionProof, equals('I run 5km every morning'));
        expect(identity.whenText, equals('Every morning at 6am'));
        expect(identity.whereText, equals('At the local park'));
        expect(identity.howText, equals('By putting on my running shoes first'));
        expect(identity.createdAt, equals(testDateTime));
        expect(identity.lastUpdated, equals(testLastUpdated));
      });

      test('handles Appwrite \$id field', () {
        final json = {
          '\$id': 'appwrite-id-123',
          'user_id': 'user-456',
          'identity_label': 'Test',
          'identity_sentence': 'I am a Test',
          'action_proof': 'Proof',
          'when_text': 'When',
          'where_text': 'Where',
          'how_text': 'How',
          'created_at': testDateTime.toIso8601String(),
        };

        final identity = IdentityEntity.fromJson(json);
        expect(identity.id, equals('appwrite-id-123'));
      });

      test('handles missing optional fields with defaults', () {
        final json = <String, dynamic>{
          'id': 'identity-123',
          'created_at': testDateTime.toIso8601String(),
        };

        final identity = IdentityEntity.fromJson(json);

        expect(identity.userId, equals(''));
        expect(identity.identityLabel, equals(''));
        expect(identity.identitySentence, equals(''));
        expect(identity.actionProof, equals(''));
        expect(identity.whenText, equals(''));
        expect(identity.whereText, equals(''));
        expect(identity.howText, equals(''));
        expect(identity.lastUpdated, isNull);
      });

      test('handles null created_at with current time', () {
        final json = <String, dynamic>{
          'id': 'identity-123',
        };

        final beforeTest = DateTime.now();
        final identity = IdentityEntity.fromJson(json);
        final afterTest = DateTime.now();

        expect(identity.createdAt.isAfter(beforeTest.subtract(const Duration(seconds: 1))), isTrue);
        expect(identity.createdAt.isBefore(afterTest.add(const Duration(seconds: 1))), isTrue);
      });
    });

    group('copyWith', () {
      test('creates new instance with modified fields', () {
        final updatedIdentity = testIdentity.copyWith(
          identityLabel: 'Athlete',
          identitySentence: 'I am an Athlete',
        );

        expect(updatedIdentity.identityLabel, equals('Athlete'));
        expect(updatedIdentity.identitySentence, equals('I am an Athlete'));
        // Unchanged fields remain the same
        expect(updatedIdentity.id, equals(testIdentity.id));
        expect(updatedIdentity.userId, equals(testIdentity.userId));
        expect(updatedIdentity.actionProof, equals(testIdentity.actionProof));
      });

      test('returns new instance (immutability)', () {
        final updatedIdentity = testIdentity.copyWith(identityLabel: 'New Label');

        expect(updatedIdentity, isNot(same(testIdentity)));
        expect(testIdentity.identityLabel, equals('Runner')); // Original unchanged
      });

      test('allows updating all fields', () {
        final newDateTime = DateTime(2025, 6, 1);
        final updated = testIdentity.copyWith(
          id: 'new-id',
          userId: 'new-user',
          identityLabel: 'New Label',
          identitySentence: 'New Sentence',
          actionProof: 'New Proof',
          whenText: 'New When',
          whereText: 'New Where',
          howText: 'New How',
          createdAt: newDateTime,
          lastUpdated: newDateTime,
        );

        expect(updated.id, equals('new-id'));
        expect(updated.userId, equals('new-user'));
        expect(updated.identityLabel, equals('New Label'));
        expect(updated.whenText, equals('New When'));
      });
    });

    group('Equatable', () {
      test('two entities with same props are equal', () {
        final identity1 = IdentityEntity(
          id: 'identity-123',
          userId: 'user-456',
          identityLabel: 'Runner',
          identitySentence: 'I am a Runner',
          actionProof: 'I run',
          whenText: 'Morning',
          whereText: 'Park',
          howText: 'Shoes first',
          createdAt: testDateTime,
        );

        final identity2 = IdentityEntity(
          id: 'identity-123',
          userId: 'user-456',
          identityLabel: 'Runner',
          identitySentence: 'I am a Runner',
          actionProof: 'I run',
          whenText: 'Morning',
          whereText: 'Park',
          howText: 'Shoes first',
          createdAt: testDateTime,
        );

        expect(identity1, equals(identity2));
        expect(identity1.hashCode, equals(identity2.hashCode));
      });

      test('two entities with different props are not equal', () {
        final identity1 = testIdentity;
        final identity2 = testIdentity.copyWith(identityLabel: 'Different');

        expect(identity1, isNot(equals(identity2)));
      });
    });

    group('round-trip serialization', () {
      test('toJson then fromJson produces equal entity', () {
        final json = testIdentity.toJson();
        final restored = IdentityEntity.fromJson(json);

        expect(restored, equals(testIdentity));
      });
    });
  });
}
