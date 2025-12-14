/// Login screen with email/password authentication
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input.dart';
import '../state/authentication_bloc.dart';

/// Login screen for user authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } else if (state is AuthenticationOnboardingRequired) {
            Navigator.pushNamedAndRemoveUntil(
              context, 
              '/identity-onboarding', 
              (route) => false,
            );
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_formatErrorMessage(state.message)),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthenticationLoading;
          
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo and title
                        _buildHeader(),
                        const SizedBox(height: 48),
                        
                        // Email field
                        CustomTextField(
                          label: 'Email',
                          hint: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          enabled: !isLoading,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16),
                        
                        // Password field
                        CustomTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: _passwordController,
                          obscureText: true,
                          prefixIcon: Icons.lock_outlined,
                          enabled: !isLoading,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 8),
                        
                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: isLoading ? null : _handleForgotPassword,
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Login button
                        CustomButton(
                          text: 'Sign In',
                          onPressed: isLoading ? null : _handleLogin,
                          isLoading: isLoading,
                          isFullWidth: true,
                        ),
                        const SizedBox(height: 24),
                        
                        // Sign up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: isLoading 
                                  ? null 
                                  : () => Navigator.pushReplacementNamed(
                                      context, 
                                      '/signup',
                                    ),
                              child: Text(
                                'Sign Up',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
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
        Text(
          'Welcome Back',
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue your transformation journey',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
        AuthenticationLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleForgotPassword() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      context.read<AuthenticationBloc>().add(
        AuthenticationPasswordResetRequested(email: email),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _formatErrorMessage(String message) {
    if (message.toLowerCase().contains('invalid') ||
        message.toLowerCase().contains('wrong') ||
        message.toLowerCase().contains('incorrect')) {
      return 'Invalid email or password. Please try again.';
    }
    if (message.toLowerCase().contains('user not found') ||
        message.toLowerCase().contains('no user')) {
      return 'No account found with this email.';
    }
    if (message.toLowerCase().contains('network') ||
        message.toLowerCase().contains('connection')) {
      return 'Network error. Please check your connection.';
    }
    return message;
  }
}
