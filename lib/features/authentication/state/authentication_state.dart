/// Authentication states for BLoC state management
part of 'authentication_bloc.dart';

/// Base class for authentication states
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// Initial authentication state
class AuthenticationInitial extends AuthenticationState {}

/// Loading state during authentication operations
class AuthenticationLoading extends AuthenticationState {}

/// Authenticated state with user data
class AuthenticationAuthenticated extends AuthenticationState {
  final Map<String, dynamic> user;
  final bool hasCompletedOnboarding;

  const AuthenticationAuthenticated({
    required this.user,
    this.hasCompletedOnboarding = false,
  });

  @override
  List<Object> get props => [user, hasCompletedOnboarding];

  AuthenticationAuthenticated copyWith({
    Map<String, dynamic>? user,
    bool? hasCompletedOnboarding,
  }) {
    return AuthenticationAuthenticated(
      user: user ?? this.user,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }
}

/// Unauthenticated state
class AuthenticationUnauthenticated extends AuthenticationState {}

/// State when user needs to complete onboarding
class AuthenticationOnboardingRequired extends AuthenticationState {
  final Map<String, dynamic> user;

  const AuthenticationOnboardingRequired({required this.user});

  @override
  List<Object> get props => [user];
}

/// Authentication failure state with error message
class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

/// State after password reset email is sent
class AuthenticationPasswordResetSent extends AuthenticationState {
  final String email;

  const AuthenticationPasswordResetSent({required this.email});

  @override
  List<Object> get props => [email];
}
