/// Identity Onboarding Feature
/// 
/// Manages the user's identity creation process with a 4-step onboarding flow:
/// 1. Identity Label - Define who you want to become
/// 2. Action Proof - What action proves this identity
/// 3. Implementation Intention - When, where, and how will you do it
/// 4. Review - Confirm your choices
library identity_onboarding;

// Data Layer
export 'data/entities/identity_entity.dart';
export 'data/repository/identity_repository.dart';
export 'data/repository/identity_repository_impl.dart';

// State Management
export 'state/identity_onboarding_bloc.dart';

// UI Layer
export 'ui/identity_onboarding_screen.dart';
