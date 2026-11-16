import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: AppTextStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'ES',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'Example Student',
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'student@example.com',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Computer Science • Class of 2027',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              const Divider(color: AppColors.border),

              ListTile(
                leading: const Icon(
                  Icons.bookmark_outline,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Saved experiences',
                  style: AppTextStyles.body,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.saved);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.business_outlined,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Following',
                  style: AppTextStyles.body,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.following);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Internship verification',
                  style: AppTextStyles.body,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.verification);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}