import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:onestep/features/identity_onboarding/data/entities/identity_entity.dart';
import 'package:onestep/features/identity_onboarding/state/identity_onboarding_bloc.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockIdentityRepository mockRepository;

  setUp(() {
    mockRepository = MockIdentityRepository();
  });

  group('IdentityOnboardingBloc', () {
    final testDateTime = DateTime(2024, 1, 15, 10, 30);

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
    );

    group('StartOnboarding', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'emits [InProgress] with userId and step 1',
        build: () => IdentityOnboardingBloc(mockRepository),
        act: (bloc) => bloc.add(const StartOnboarding('user-456')),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.userId, 'userId', 'user-456')
              .having((s) => s.currentStep, 'currentStep', 1),
        ],
      );
    });

    group('NextStep', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'increments step when canProceed is true',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 1,
          userId: 'user-456',
          identityLabel: 'Runner', // Has required field for step 1
        ),
        act: (bloc) => bloc.add(NextStep()),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.currentStep, 'currentStep', 2),
        ],
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'does not increment beyond totalSteps (4)',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 4,
          userId: 'user-456',
          identityLabel: 'Runner',
          actionProof: 'I run',
          whenText: 'Morning',
          whereText: 'Park',
          howText: 'Shoes',
        ),
        act: (bloc) => bloc.add(NextStep()),
        expect: () => [], // No state change
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'does not increment when canProceed is false',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 1,
          userId: 'user-456',
          // Missing identityLabel, so canProceed should be false
        ),
        act: (bloc) => bloc.add(NextStep()),
        expect: () => [], // No state change - canProceed is false
      );
    });

    group('PreviousStep', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'decrements step when current step > 1',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 3,
          userId: 'user-456',
        ),
        act: (bloc) => bloc.add(PreviousStep()),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.currentStep, 'currentStep', 2),
        ],
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'does not decrement below step 1',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 1,
          userId: 'user-456',
        ),
        act: (bloc) => bloc.add(PreviousStep()),
        expect: () => [], // No state change
      );
    });

    group('UpdateIdentityLabel', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'updates identity label in progress state',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 1,
          userId: 'user-456',
        ),
        act: (bloc) => bloc.add(const UpdateIdentityLabel('Runner')),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.identityLabel, 'identityLabel', 'Runner'),
        ],
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'does nothing when not in progress state',
        build: () => IdentityOnboardingBloc(mockRepository),
        act: (bloc) => bloc.add(const UpdateIdentityLabel('Runner')),
        expect: () => [],
      );
    });

    group('UpdateActionProof', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'updates action proof in progress state',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 2,
          userId: 'user-456',
        ),
        act: (bloc) => bloc.add(const UpdateActionProof('I run 5km every morning')),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.actionProof, 'actionProof', 'I run 5km every morning'),
        ],
      );
    });

    group('UpdateImplementationIntention', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'updates when, where, how text in progress state',
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 3,
          userId: 'user-456',
        ),
        act: (bloc) => bloc.add(const UpdateImplementationIntention(
          whenText: 'Every morning at 6am',
          whereText: 'At the local park',
          howText: 'By putting on my running shoes first',
        )),
        expect: () => [
          isA<IdentityOnboardingInProgress>()
              .having((s) => s.whenText, 'whenText', 'Every morning at 6am')
              .having((s) => s.whereText, 'whereText', 'At the local park')
              .having((s) => s.howText, 'howText', 'By putting on my running shoes first'),
        ],
      );
    });

    group('CompleteOnboarding', () {
      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'emits [Loading, Completed] on successful completion',
        setUp: () {
          when(mockRepository.createIdentity(any))
              .thenAnswer((_) async => testIdentity);
        },
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 4,
          userId: 'user-456',
          identityLabel: 'Runner',
          actionProof: 'I run 5km every morning',
          whenText: 'Every morning at 6am',
          whereText: 'At the local park',
          howText: 'By putting on my running shoes first',
        ),
        act: (bloc) => bloc.add(CompleteOnboarding()),
        expect: () => [
          isA<IdentityOnboardingLoading>(),
          isA<IdentityOnboardingCompleted>()
              .having((s) => s.identityLabel, 'identityLabel', 'Runner')
              .having((s) => s.identitySentence, 'identitySentence', 'I am a Runner'),
        ],
        verify: (_) {
          verify(mockRepository.createIdentity(any)).called(1);
        },
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'emits [Loading, Error] when repository throws',
        setUp: () {
          when(mockRepository.createIdentity(any))
              .thenThrow(Exception('Database error'));
        },
        build: () => IdentityOnboardingBloc(mockRepository),
        seed: () => const IdentityOnboardingInProgress(
          currentStep: 4,
          userId: 'user-456',
          identityLabel: 'Runner',
          actionProof: 'I run 5km every morning',
          whenText: 'Every morning at 6am',
          whereText: 'At the local park',
          howText: 'By putting on my running shoes first',
        ),
        act: (bloc) => bloc.add(CompleteOnboarding()),
        expect: () => [
          isA<IdentityOnboardingLoading>(),
          isA<IdentityOnboardingError>()
              .having((s) => s.message, 'message', contains('Failed to save identity')),
        ],
      );

      blocTest<IdentityOnboardingBloc, IdentityOnboardingState>(
        'does nothing when not in progress state',
        build: () => IdentityOnboardingBloc(mockRepository),
        act: (bloc) => bloc.add(CompleteOnboarding()),
        expect: () => [],
      );
    });
  });
}
