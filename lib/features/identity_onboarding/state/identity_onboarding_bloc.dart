/// Identity onboarding BLoC for managing onboarding flow
library identity_onboarding_bloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/entities/identity_entity.dart';
import '../data/repository/identity_repository.dart';

part 'identity_onboarding_event.dart';
part 'identity_onboarding_state.dart';

/// BLoC for managing identity onboarding process
class IdentityOnboardingBloc extends Bloc<IdentityOnboardingEvent, IdentityOnboardingState> {
  final IdentityRepository _repository;
  static const int totalSteps = 4;

  IdentityOnboardingBloc(this._repository) : super(const IdentityOnboardingInitial()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<UpdateIdentityLabel>(_onUpdateIdentityLabel);
    on<UpdateActionProof>(_onUpdateActionProof);
    on<UpdateImplementationIntention>(_onUpdateImplementationIntention);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  void _onStartOnboarding(StartOnboarding event, Emitter<IdentityOnboardingState> emit) {
    emit(IdentityOnboardingInProgress(
      currentStep: 1,
      userId: event.userId,
    ));
  }

  void _onNextStep(NextStep event, Emitter<IdentityOnboardingState> emit) {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      if (current.currentStep < totalSteps && current.canProceed) {
        emit(current.copyWith(currentStep: current.currentStep + 1));
      }
    }
  }

  void _onPreviousStep(PreviousStep event, Emitter<IdentityOnboardingState> emit) {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      if (current.currentStep > 1) {
        emit(current.copyWith(currentStep: current.currentStep - 1));
      }
    }
  }

  void _onUpdateIdentityLabel(UpdateIdentityLabel event, Emitter<IdentityOnboardingState> emit) {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      emit(current.copyWith(identityLabel: event.identityLabel));
    }
  }

  void _onUpdateActionProof(UpdateActionProof event, Emitter<IdentityOnboardingState> emit) {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      emit(current.copyWith(actionProof: event.actionProof));
    }
  }

  void _onUpdateImplementationIntention(
    UpdateImplementationIntention event,
    Emitter<IdentityOnboardingState> emit,
  ) {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      emit(current.copyWith(
        whenText: event.whenText,
        whereText: event.whereText,
        howText: event.howText,
      ));
    }
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<IdentityOnboardingState> emit,
  ) async {
    if (state is IdentityOnboardingInProgress) {
      final current = state as IdentityOnboardingInProgress;
      emit(const IdentityOnboardingLoading());

      try {
        final identity = IdentityEntity(
          id: '',
          userId: current.userId,
          identityLabel: current.identityLabel,
          identitySentence: 'I am a ${current.identityLabel}',
          actionProof: current.actionProof,
          whenText: current.whenText,
          whereText: current.whereText,
          howText: current.howText,
          createdAt: DateTime.now(),
        );

        await _repository.createIdentity(identity);
        emit(IdentityOnboardingCompleted(
          identityLabel: current.identityLabel,
          identitySentence: 'I am a ${current.identityLabel}',
        ));
      } catch (e) {
        emit(IdentityOnboardingError('Failed to save identity: $e'));
      }
    }
  }
}
