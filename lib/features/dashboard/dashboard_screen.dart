import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Main dashboard screen showing overview of user's habits and progress
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Identity Progress',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 24),
            // Identity Score Card
            CustomCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Identity Score',
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        '0/100',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0,
                    backgroundColor: AppColors.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Habits',
                  style: AppTextStyles.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/habit-creation');
                  },
                  child: const Text('+ New Habit'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const EmptyStateWidget(
              message: 'No habits yet',
              icon: Icons.check_circle_outline,
            ),
            const SizedBox(height: 32),
            Text(
              'Today\'s Progress',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Completions',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Text(
                        '0 / 0',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Streak',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: AppColors.warning,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '0 days',
                            style: AppTextStyles.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/habit-creation');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
