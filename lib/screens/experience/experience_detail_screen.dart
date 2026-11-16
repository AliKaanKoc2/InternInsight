import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    // ModalRoute.of(context) => finds the route of detailed widget
    // setting => accessing the settings of route
    // arguments => takes data which is coming from home

    if (arguments is! Experience) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Experience'),
        ),
        body: const Center(
          child: Text('No experience selected.'),
        ),
      );
    }

    final experience = arguments;
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
            children: [
              Text(
                experience.company,
                style: AppTextStyles.title,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                experience.position,
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                experience.department,
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
                      '${experience.location} • ${experience.workType}',
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
                      experience.duration,
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              Divider(color: AppColors.border),
              SizedBox(height: AppSpacing.md),

              Text(
                'Overall experience',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.warning,
                    size: 22,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    '${experience.rating} / 5',
                    style: AppTextStyles.heading,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                experience.recommends
                    ? 'I would recommend this internship.'
                    : 'I would not recommend this internship.',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'My review',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                experience.review,
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'Pros',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                experience.pros.map((pro) => '• $pro').join('\n'),
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'Cons',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                experience.cons.map((con) => '• $con').join('\n'),
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.lg),
              Divider(color: AppColors.border),
              SizedBox(height: AppSpacing.md),

              Text(
                'Interview process',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Application channel: ${experience.applicationChannel}',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Rounds: ${experience.interviewRounds} • '
                'Difficulty: ${experience.interviewDifficulty}',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                experience.interviewDescription,
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.lg),

              Text(
                'Technologies used',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: experience.technologies.map((technology) {
                  return Chip(
                    label: Text(technology),
                  );
                }).toList(),
              ),
            ],
          )
        )
      )
    );
  }
}
