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
                    '4 / 5',
                    style: AppTextStyles.heading,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                'I would recommend this internship.',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'My review',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                'During my internship, I worked on backend APIs and helped '
                    'the team test new features. Regular code reviews improved '
                    'my coding skills and understanding of teamwork.',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'Pros',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                '• Supportive team and regular mentoring\n'
                    '• Hands-on experience with real projects\n'
                    '• Flexible hybrid working arrangement',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.md),

              Text(
                'Cons',
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.sm),

              Text(
                '• Limited onboarding documentation\n'
                    '• Some tasks were repetitive',
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
                'Application channel: Company website',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Rounds: 2 • Difficulty: Moderate',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'The process started with an HR interview, followed by '
                    'a technical interview covering programming fundamentals '
                    'and a short coding exercise.',
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
                children: [
                  Chip(label: Text('Python')),
                  Chip(label: Text('SQL')),
                  Chip(label: Text('Git')),
                  Chip(label: Text('REST APIs')),
                ],
              ),
            ],
          )
        )
      )
    );
  }
}
