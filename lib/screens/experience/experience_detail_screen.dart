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
            children: const [
              Text(
                'Example Company',
                style: AppTextStyles.title,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Software Engineering Intern',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                'Engineering Department',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Istanbul, Türkiye • Hybrid',
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'July 2026 – September 2026',
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }
}
