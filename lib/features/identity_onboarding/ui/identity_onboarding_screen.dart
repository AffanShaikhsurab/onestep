import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../state/identity_onboarding_bloc.dart';

/// Identity onboarding screen with 4-step process
class IdentityOnboardingScreen extends StatelessWidget {
  final String userId;

  const IdentityOnboardingScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdentityOnboardingBloc(
        context.read(),
      )..add(StartOnboarding(userId)),
      child: const _IdentityOnboardingView(),
    );
  }
}

class _IdentityOnboardingView extends StatelessWidget {
  const _IdentityOnboardingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<IdentityOnboardingBloc, IdentityOnboardingState>(
        listener: (context, state) {
          if (state is IdentityOnboardingCompleted) {
            // Navigate to next screen (e.g., dashboard)
            Navigator.of(context).pushReplacementNamed('/dashboard');
          } else if (state is IdentityOnboardingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IdentityOnboardingLoading) {
            return const Center(child: LoadingWidget());
          }

          if (state is IdentityOnboardingInProgress) {
            return SafeArea(
              child: Column(
                children: [
                  _buildProgressIndicator(context, state),
                  Expanded(
                    child: _buildCurrentStep(context, state),
                  ),
                  _buildNavigationButtons(context, state),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, IdentityOnboardingInProgress state) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Step ${state.currentStep} of 4',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: state.currentStep / 4,
            backgroundColor: AppColors.surface,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context, IdentityOnboardingInProgress state) {
    switch (state.currentStep) {
      case 1:
        return _IdentityLabelStep(currentValue: state.identityLabel);
      case 2:
        return _ActionProofStep(currentValue: state.actionProof);
      case 3:
        return _ImplementationIntentionStep(
          whenText: state.whenText,
          whereText: state.whereText,
          howText: state.howText,
        );
      case 4:
        return _ReviewStep(state: state);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildNavigationButtons(BuildContext context, IdentityOnboardingInProgress state) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (state.currentStep > 1)
            Expanded(
              child: CustomButton(
                text: 'Back',
                onPressed: () {
                  context.read<IdentityOnboardingBloc>().add(const PreviousStep());
                },
                variant: ButtonVariant.secondary,
              ),
            ),
          if (state.currentStep > 1) const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: state.currentStep == 4 ? 'Complete' : 'Next',
              onPressed: state.canProceed
                  ? () {
                      if (state.currentStep == 4) {
                        context.read<IdentityOnboardingBloc>().add(const CompleteOnboarding());
                      } else {
                        context.read<IdentityOnboardingBloc>().add(const NextStep());
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentityLabelStep extends StatelessWidget {
  final String currentValue;

  const _IdentityLabelStep({required this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who do you want to become?',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Define your desired identity in one word or phrase',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            label: 'Identity Label',
            hint: 'e.g., Athlete, Writer, Entrepreneur',
            initialValue: currentValue,
            onChanged: (value) {
              context.read<IdentityOnboardingBloc>().add(UpdateIdentityLabel(value));
            },
          ),
        ],
      ),
    );
  }
}

class _ActionProofStep extends StatelessWidget {
  final String currentValue;

  const _ActionProofStep({required this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What action proves this identity?',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Define a specific action that embodies your desired identity',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            label: 'Action Proof',
            hint: 'e.g., Run 5km, Write 500 words, Make 10 sales calls',
            initialValue: currentValue,
            maxLines: 3,
            onChanged: (value) {
              context.read<IdentityOnboardingBloc>().add(UpdateActionProof(value));
            },
          ),
        ],
      ),
    );
  }
}

class _ImplementationIntentionStep extends StatelessWidget {
  final String whenText;
  final String whereText;
  final String howText;

  const _ImplementationIntentionStep({
    required this.whenText,
    required this.whereText,
    required this.howText,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When, where, and how?',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Plan the specifics of your action',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            label: 'When will you do it?',
            hint: 'e.g., Every morning at 6 AM',
            initialValue: whenText,
            onChanged: (value) {
              context.read<IdentityOnboardingBloc>().add(
                    UpdateImplementationIntention(
                      whenText: value,
                      whereText: whereText,
                      howText: howText,
                    ),
                  );
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Where will you do it?',
            hint: 'e.g., At the local park',
            initialValue: whereText,
            onChanged: (value) {
              context.read<IdentityOnboardingBloc>().add(
                    UpdateImplementationIntention(
                      whenText: whenText,
                      whereText: value,
                      howText: howText,
                    ),
                  );
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'How will you do it?',
            hint: 'e.g., Start slow, focus on consistency',
            initialValue: howText,
            maxLines: 3,
            onChanged: (value) {
              context.read<IdentityOnboardingBloc>().add(
                    UpdateImplementationIntention(
                      whenText: whenText,
                      whereText: whereText,
                      howText: value,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _ReviewStep extends StatelessWidget {
  final IdentityOnboardingInProgress state;

  const _ReviewStep({required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your identity',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Make sure everything looks good',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReviewItem(
                  context,
                  'Identity',
                  state.identityLabel,
                ),
                const Divider(height: 32),
                _buildReviewItem(
                  context,
                  'Action',
                  state.actionProof,
                ),
                const Divider(height: 32),
                _buildReviewItem(
                  context,
                  'When',
                  state.whenText,
                ),
                const SizedBox(height: 16),
                _buildReviewItem(
                  context,
                  'Where',
                  state.whereText,
                ),
                const SizedBox(height: 16),
                _buildReviewItem(
                  context,
                  'How',
                  state.howText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}
