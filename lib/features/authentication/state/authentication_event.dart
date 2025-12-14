/// Authentication events for BLoC state management
part of 'authentication_bloc.dart';

/// Base class for authentication events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// Event to start authentication check
class AuthenticationStarted extends AuthenticationEvent {}

/// Event to request login with email and password
class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// Event to request signup with email, password, and name
class AuthenticationSignupRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;

  const AuthenticationSignupRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}

/// Event to request logout
class AuthenticationLogoutRequested extends AuthenticationEvent {}

/// Event to request password reset
class AuthenticationPasswordResetRequested extends AuthenticationEvent {
  final String email;

  const AuthenticationPasswordResetRequested({required this.email});

  @override
  List<Object> get props => [email];
}

/// Event when onboarding is completed
class AuthenticationOnboardingCompleted extends AuthenticationEvent {}

/// Event to check current authentication status
class AuthenticationStatusRequested extends AuthenticationEvent {}
