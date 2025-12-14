import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../authentication/authentication.dart';

/// User profile screen with settings and account management
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'User Name',
                    style: AppTextStyles.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'user@example.com',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Account Settings',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () {
                // Navigate to notifications settings
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.lock_outline,
              title: 'Privacy',
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            const SizedBox(height: 32),
            Text(
              'App Settings',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              icon: Icons.palette_outlined,
              title: 'Appearance',
              onTap: () {
                // Navigate to appearance settings
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.language_outlined,
              title: 'Language',
              onTap: () {
                // Navigate to language settings
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Support',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              icon: Icons.help_outline,
              title: 'Help & FAQ',
              onTap: () {
                // Navigate to help
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                // Navigate to about
              },
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Log Out',
              onPressed: () {
                _showLogoutDialog(context);
              },
              variant: ButtonVariant.secondary,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyLarge,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthenticationBloc>().add(const LogoutRequested());
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
