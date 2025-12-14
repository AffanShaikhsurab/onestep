/// Events for identity onboarding
part of 'identity_onboarding_bloc.dart';

/// Base class for identity onboarding events
abstract class IdentityOnboardingEvent extends Equatable {
  const IdentityOnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Start the onboarding process
class StartOnboarding extends IdentityOnboardingEvent {
  final String userId;

  const StartOnboarding(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Move to next step
class NextStep extends IdentityOnboardingEvent {
  const NextStep();
}

/// Move to previous step
class PreviousStep extends IdentityOnboardingEvent {
  const PreviousStep();
}

/// Update identity label (step 1)
class UpdateIdentityLabel extends IdentityOnboardingEvent {
  final String identityLabel;

  const UpdateIdentityLabel(this.identityLabel);

  @override
  List<Object?> get props => [identityLabel];
}

/// Update action proof (step 2)
class UpdateActionProof extends IdentityOnboardingEvent {
  final String actionProof;

  const UpdateActionProof(this.actionProof);

  @override
  List<Object?> get props => [actionProof];
}

/// Update implementation intention (step 3)
class UpdateImplementationIntention extends IdentityOnboardingEvent {
  final String whenText;
  final String whereText;
  final String howText;

  const UpdateImplementationIntention({
    required this.whenText,
    required this.whereText,
    required this.howText,
  });

  @override
  List<Object?> get props => [whenText, whereText, howText];
}

/// Complete onboarding
class CompleteOnboarding extends IdentityOnboardingEvent {
  const CompleteOnboarding();
}
