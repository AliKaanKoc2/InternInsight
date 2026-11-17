import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/experience.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      experience.company,
                      style: AppTextStyles.heading,
                    ),
                  ),
                  if (onRemove != null)
                    IconButton(
                      tooltip: 'Remove from saved',
                      onPressed: onRemove,
                      icon: const Icon(Icons.close),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                experience.position,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${experience.location} • ${experience.workType}',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.sm,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '${experience.rating} / 5',
                        style: AppTextStyles.label,
                      ),
                    ],
                  ),
                  if (experience.isVerified)
                    const Chip(
                      avatar: Icon(
                        Icons.verified,
                        size: 18,
                        color: AppColors.success,
                      ),
                      label: Text('Verified'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}