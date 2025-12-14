import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:onestep/features/authentication/state/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthenticationBloc', () {
    final testUser = {
      '\$id': 'user-123',
      'name': 'Test User',
      'email': 'test@example.com',
    };

    group('AuthenticationStarted', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Authenticated] when user is authenticated',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenAnswer((_) async => true);
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => testUser);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStarted()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationAuthenticated>()
              .having((s) => s.user, 'user', testUser),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Unauthenticated] when user is not authenticated',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenAnswer((_) async => false);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStarted()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationUnauthenticated>(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Unauthenticated] when getCurrentUser returns null',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenAnswer((_) async => true);
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => null);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStarted()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationUnauthenticated>(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when authentication check throws',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenThrow(Exception('Network error'));
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStarted()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Authentication check failed')),
        ],
      );
    });

    group('AuthenticationLoginRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Authenticated] on successful login',
        setUp: () {
          when(mockAuthService.signIn('test@example.com', 'password123'))
              .thenAnswer((_) async => {'sessionId': 'session-123'});
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => testUser);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationLoginRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationAuthenticated>(),
        ],
        verify: (_) {
          verify(mockAuthService.signIn('test@example.com', 'password123')).called(1);
        },
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when login fails',
        setUp: () {
          when(mockAuthService.signIn('test@example.com', 'wrongpassword'))
              .thenThrow(Exception('Invalid credentials'));
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationLoginRequested(
          email: 'test@example.com',
          password: 'wrongpassword',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Login failed')),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when getCurrentUser returns null after login',
        setUp: () {
          when(mockAuthService.signIn('test@example.com', 'password123'))
              .thenAnswer((_) async => {'sessionId': 'session-123'});
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => null);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationLoginRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Login failed')),
        ],
      );
    });

    group('AuthenticationSignupRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, OnboardingRequired] on successful signup',
        setUp: () {
          when(mockAuthService.signUp('new@example.com', 'password123', 'New User'))
              .thenAnswer((_) async => testUser);
          when(mockAuthService.signIn('new@example.com', 'password123'))
              .thenAnswer((_) async => {'sessionId': 'session-123'});
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => testUser);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationSignupRequested(
          email: 'new@example.com',
          password: 'password123',
          name: 'New User',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationOnboardingRequired>()
              .having((s) => s.user, 'user', testUser),
        ],
        verify: (_) {
          verify(mockAuthService.signUp('new@example.com', 'password123', 'New User')).called(1);
          verify(mockAuthService.signIn('new@example.com', 'password123')).called(1);
        },
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when signup fails',
        setUp: () {
          when(mockAuthService.signUp('existing@example.com', 'password123', 'User'))
              .thenThrow(Exception('User already exists'));
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationSignupRequested(
          email: 'existing@example.com',
          password: 'password123',
          name: 'User',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Signup failed')),
        ],
      );
    });

    group('AuthenticationLogoutRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Unauthenticated] on successful logout',
        setUp: () {
          when(mockAuthService.signOut())
              .thenAnswer((_) async {});
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationUnauthenticated>(),
        ],
        verify: (_) {
          verify(mockAuthService.signOut()).called(1);
        },
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when logout fails',
        setUp: () {
          when(mockAuthService.signOut())
              .thenThrow(Exception('Logout error'));
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Logout failed')),
        ],
      );
    });

    group('AuthenticationPasswordResetRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, PasswordResetSent] on successful reset request',
        setUp: () {
          when(mockAuthService.createPasswordRecovery(
            'test@example.com',
            'onestep://reset-password',
          )).thenAnswer((_) async => {'userId': 'user-123'});
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationPasswordResetRequested(
          email: 'test@example.com',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationPasswordResetSent>()
              .having((s) => s.email, 'email', 'test@example.com'),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, Failure] when password reset fails',
        setUp: () {
          when(mockAuthService.createPasswordRecovery(
            'invalid@example.com',
            'onestep://reset-password',
          )).thenThrow(Exception('User not found'));
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(const AuthenticationPasswordResetRequested(
          email: 'invalid@example.com',
        )),
        expect: () => [
          isA<AuthenticationLoading>(),
          isA<AuthenticationFailure>()
              .having((s) => s.message, 'message', contains('Password reset failed')),
        ],
      );
    });

    group('AuthenticationStatusRequested', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Authenticated] when user is authenticated',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenAnswer((_) async => true);
          when(mockAuthService.getCurrentUser())
              .thenAnswer((_) async => testUser);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStatusRequested()),
        expect: () => [
          isA<AuthenticationAuthenticated>(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Unauthenticated] when user is not authenticated',
        setUp: () {
          when(mockAuthService.isAuthenticated())
              .thenAnswer((_) async => false);
        },
        build: () => AuthenticationBloc(mockAuthService),
        act: (bloc) => bloc.add(AuthenticationStatusRequested()),
        expect: () => [
          isA<AuthenticationUnauthenticated>(),
        ],
      );
    });
  });
}
