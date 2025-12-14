/// Authentication BLoC for managing authentication state
library authentication_bloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/constants/app_constants.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// BLoC for managing user authentication state
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  AuthenticationBloc(this._authService) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<AuthenticationLoginRequested>(_onLoginRequested);
    on<AuthenticationSignupRequested>(_onSignupRequested);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    on<AuthenticationPasswordResetRequested>(_onPasswordResetRequested);
    on<AuthenticationOnboardingCompleted>(_onOnboardingCompleted);
    on<AuthenticationStatusRequested>(_onStatusRequested);
  }

  Future<void> _onAuthenticationStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    
    try {
      final isAuthenticated = await _authService.isAuthenticated();
      
      if (isAuthenticated) {
        final user = await _authService.getCurrentUser();
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          final hasCompletedOnboarding = 
              prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
          
          emit(AuthenticationAuthenticated(
            user: user,
            hasCompletedOnboarding: hasCompletedOnboarding,
          ));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(message: 'Authentication check failed: $e'));
    }
  }

  Future<void> _onLoginRequested(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    
    try {
      await _authService.signIn(event.email, event.password);
      final user = await _authService.getCurrentUser();
      
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final hasCompletedOnboarding = 
            prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
        
        emit(AuthenticationAuthenticated(
          user: user,
          hasCompletedOnboarding: hasCompletedOnboarding,
        ));
      } else {
        emit(const AuthenticationFailure(message: 'Login failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(message: 'Login failed: $e'));
    }
  }

  Future<void> _onSignupRequested(
    AuthenticationSignupRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    
    try {
      await _authService.signUp(event.email, event.password, event.name);
      await _authService.signIn(event.email, event.password);
      final user = await _authService.getCurrentUser();
      
      if (user != null) {
        emit(AuthenticationOnboardingRequired(user: user));
      } else {
        emit(const AuthenticationFailure(message: 'Signup failed'));
      }
    } catch (e) {
      emit(AuthenticationFailure(message: 'Signup failed: $e'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    
    try {
      await _authService.signOut();
      emit(AuthenticationUnauthenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: 'Logout failed: $e'));
    }
  }

  Future<void> _onPasswordResetRequested(
    AuthenticationPasswordResetRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    
    try {
      await _authService.createPasswordRecovery(
        event.email,
        'onestep://reset-password',
      );
      emit(AuthenticationPasswordResetSent(email: event.email));
    } catch (e) {
      emit(AuthenticationFailure(message: 'Password reset failed: $e'));
    }
  }

  Future<void> _onOnboardingCompleted(
    AuthenticationOnboardingCompleted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyOnboardingCompleted, true);
      
      if (state is AuthenticationOnboardingRequired) {
        final user = (state as AuthenticationOnboardingRequired).user;
        emit(AuthenticationAuthenticated(
          user: user,
          hasCompletedOnboarding: true,
        ));
      }
    } catch (e) {
      emit(AuthenticationFailure(message: 'Failed to complete onboarding: $e'));
    }
  }

  Future<void> _onStatusRequested(
    AuthenticationStatusRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final isAuthenticated = await _authService.isAuthenticated();
      
      if (isAuthenticated) {
        final user = await _authService.getCurrentUser();
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          final hasCompletedOnboarding = 
              prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
          
          emit(AuthenticationAuthenticated(
            user: user,
            hasCompletedOnboarding: hasCompletedOnboarding,
          ));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(message: 'Status check failed: $e'));
    }
  }
}
