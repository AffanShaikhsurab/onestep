import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../state/habit_creation_bloc.dart';

/// Habit creation screen
class HabitCreationScreen extends StatelessWidget {
  final String userId;
  final String identityId;

  const HabitCreationScreen({
    super.key,
    required this.userId,
    required this.identityId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitCreationBloc(
        context.read(),
      )..add(StartHabitCreation(userId: userId, identityId: identityId)),
      child: const _HabitCreationView(),
    );
  }
}

class _HabitCreationView extends StatelessWidget {
  const _HabitCreationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Habit'),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: BlocConsumer<HabitCreationBloc, HabitCreationState>(
        listener: (context, state) {
          if (state is HabitCreationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Habit created successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.of(context).pop(state.habit);
          } else if (state is HabitCreationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HabitCreationLoading) {
            return const Center(child: LoadingWidget());
          }

          if (state is HabitCreationInProgress) {
            return _buildForm(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, HabitCreationInProgress state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Based on the Habit Loop',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Define your habit using the four-step habit loop: Cue, Craving, Response, Reward',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            label: 'Habit Name *',
            hint: 'e.g., Morning Run',
            initialValue: state.habitName,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateHabitName(value));
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Description',
            hint: 'Describe your habit...',
            initialValue: state.habitDescription,
            maxLines: 3,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateHabitDescription(value));
            },
          ),
          const SizedBox(height: 32),
          Text(
            'The Habit Loop',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: '1. Cue (Trigger) *',
            hint: 'What triggers this habit? e.g., Alarm at 6 AM',
            initialValue: state.cue,
            maxLines: 2,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateCue(value));
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: '2. Craving (Motivation)',
            hint: 'Why do you want to do this? e.g., I want to feel energized',
            initialValue: state.craving,
            maxLines: 2,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateCraving(value));
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: '3. Response (Action) *',
            hint: 'What will you do? e.g., Run for 30 minutes',
            initialValue: state.response,
            maxLines: 2,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateResponse(value));
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: '4. Reward (Benefit) *',
            hint: 'What\'s your reward? e.g., Feel accomplished and healthy',
            initialValue: state.reward,
            maxLines: 2,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateReward(value));
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Schedule',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequency (days/week) *',
                      style: AppTextStyles.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButton<int>(
                        value: state.frequency,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: List.generate(
                          7,
                          (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text('${index + 1} day${index == 0 ? '' : 's'}'),
                          ),
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<HabitCreationBloc>().add(UpdateFrequency(value));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration (minutes) *',
                      style: AppTextStyles.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButton<int>(
                        value: state.duration == 0 ? null : state.duration,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        hint: const Text('Select'),
                        items: [5, 10, 15, 20, 30, 45, 60, 90, 120]
                            .map(
                              (min) => DropdownMenuItem(
                                value: min,
                                child: Text('$min min'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<HabitCreationBloc>().add(UpdateDuration(value));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Time of Day',
            hint: 'e.g., Morning, 6:00 AM, After work',
            initialValue: state.timeOfDay,
            onChanged: (value) {
              context.read<HabitCreationBloc>().add(UpdateTimeOfDay(value));
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Create Habit',
            onPressed: state.isValid
                ? () {
                    context.read<HabitCreationBloc>().add(const SubmitHabit());
                  }
                : null,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
