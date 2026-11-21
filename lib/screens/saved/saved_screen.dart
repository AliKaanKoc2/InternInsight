import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/saved_experiences.dart';
import '../../widgets/experience_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Saved experiences',
          style: AppTextStyles.title,
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: savedExperiences,
          builder: (context, child) {
            final experiences = savedExperiences.items;

            if (experiences.isEmpty) {
              return const Center(
                child: SingleChildScrollView(
                  padding: AppSpacing.screen,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bookmark_outline,
                        size: 56,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'No saved experiences yet',
                        style: AppTextStyles.heading,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Bookmark an experience to find it here later.',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: AppSpacing.screen,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${experiences.length} saved posts',
                          style: AppTextStyles.label,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Text(
                        'Recently saved',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: AppSpacing.screen,
                    itemCount: experiences.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: AppSpacing.sm);
                    },
                    itemBuilder: (context, index) {
                      final experience = experiences[index];

                      return ExperienceCard(
                        key: ValueKey(experience.id),
                        experience: experience,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.experienceDetail,
                            arguments: experience,
                          );
                        },
                        onRemove: () {
                          savedExperiences.remove(experience.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}