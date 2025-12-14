/// States for identity onboarding
part of 'identity_onboarding_bloc.dart';

/// Base class for identity onboarding states
abstract class IdentityOnboardingState extends Equatable {
  const IdentityOnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class IdentityOnboardingInitial extends IdentityOnboardingState {
  const IdentityOnboardingInitial();
}

/// Loading state
class IdentityOnboardingLoading extends IdentityOnboardingState {
  const IdentityOnboardingLoading();
}

/// Onboarding in progress
class IdentityOnboardingInProgress extends IdentityOnboardingState {
  final int currentStep;
  final String userId;
  final String identityLabel;
  final String actionProof;
  final String whenText;
  final String whereText;
  final String howText;

  const IdentityOnboardingInProgress({
    required this.currentStep,
    required this.userId,
    this.identityLabel = '',
    this.actionProof = '',
    this.whenText = '',
    this.whereText = '',
    this.howText = '',
  });

  bool get canProceed {
    switch (currentStep) {
      case 1:
        return identityLabel.trim().isNotEmpty;
      case 2:
        return actionProof.trim().isNotEmpty;
      case 3:
        return whenText.trim().isNotEmpty &&
               whereText.trim().isNotEmpty &&
               howText.trim().isNotEmpty;
      case 4:
        return true;
      default:
        return false;
    }
  }

  IdentityOnboardingInProgress copyWith({
    int? currentStep,
    String? userId,
    String? identityLabel,
    String? actionProof,
    String? whenText,
    String? whereText,
    String? howText,
  }) {
    return IdentityOnboardingInProgress(
      currentStep: currentStep ?? this.currentStep,
      userId: userId ?? this.userId,
      identityLabel: identityLabel ?? this.identityLabel,
      actionProof: actionProof ?? this.actionProof,
      whenText: whenText ?? this.whenText,
      whereText: whereText ?? this.whereText,
      howText: howText ?? this.howText,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        userId,
        identityLabel,
        actionProof,
        whenText,
        whereText,
        howText,
      ];
}

/// Onboarding completed
class IdentityOnboardingCompleted extends IdentityOnboardingState {
  final String identityLabel;
  final String identitySentence;

  const IdentityOnboardingCompleted({
    required this.identityLabel,
    required this.identitySentence,
  });

  @override
  List<Object?> get props => [identityLabel, identitySentence];
}

/// Error state
class IdentityOnboardingError extends IdentityOnboardingState {
  final String message;

  const IdentityOnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
