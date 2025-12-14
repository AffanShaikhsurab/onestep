/// Authentication wrapper that checks auth state and routes accordingly
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/loading_widget.dart';
import '../state/authentication_bloc.dart';

/// Wrapper widget that handles authentication state and routing
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Trigger authentication check on startup
    context.read<AuthenticationBloc>().add(AuthenticationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          if (state.hasCompletedOnboarding) {
            Navigator.pushNamedAndRemoveUntil(
              context, 
              '/dashboard', 
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context, 
              '/identity-onboarding', 
              (route) => false,
            );
          }
        } else if (state is AuthenticationOnboardingRequired) {
          Navigator.pushNamedAndRemoveUntil(
            context, 
            '/identity-onboarding', 
            (route) => false,
          );
        } else if (state is AuthenticationUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context, 
            '/login', 
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoading || state is AuthenticationInitial) {
          return const _LoadingScreen();
        }
        
        if (state is AuthenticationFailure) {
          return _ErrorScreen(
            message: state.message,
            onRetry: () {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
            },
          );
        }
        
        // Default loading state while navigating
        return const _LoadingScreen();
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.trending_up,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            const LoadingWidget(message: 'Loading...'),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorScreen({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
