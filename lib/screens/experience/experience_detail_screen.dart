import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          title: const Text('Experience',
          style: AppTextStyles.title
          ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const[
              Text(
                'Internship details',
                 style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Select an experience to view its details.',
                 style: AppTextStyles.body,
              ),
            ],
          )
        )
      )
    );
  }
}
