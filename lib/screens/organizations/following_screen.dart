import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/followed_organizations.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_data.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Following',
          style: AppTextStyles.title,
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: followedOrganizations,
          builder: (context, child) {
            final organizations = followedOrganizations.items;

            if (organizations.isEmpty) {
              return const Center(
                child: SingleChildScrollView(
                  padding: AppSpacing.screen,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 56,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'No organizations followed yet',
                        style: AppTextStyles.heading,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Follow organizations to find them here.',
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
                  child: Text(
                    'Following ${organizations.length} organizations',
                    style: AppTextStyles.label,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: AppSpacing.screen,
                    itemCount: organizations.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: AppSpacing.sm);
                    },
                    itemBuilder: (context, index) {
                      final organization = organizations[index];
                      final organizationExperiences = mockExperiences
                          .where((experience) => experience.organizationId == organization.id)
                          .toList();

                      final averageRating = organizationExperiences.isEmpty
                          ? null
                          : organizationExperiences
                          .fold<double>(0, (sum, experience) => sum + experience.rating) /
                          organizationExperiences.length;

                      final experienceCount = organizationExperiences.length;

                      final experienceCountLabel = experienceCount == 1
                          ? '1 experience'
                          : '$experienceCount experiences';

                      return Card(
                        key: ValueKey(organization.id),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.organizationDetail,
                              arguments: organization,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.business_outlined,
                                  size: 32,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        organization.name,
                                        style: AppTextStyles.label,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        '${organization.industry} • ${organization.location}',
                                        style: AppTextStyles.caption,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        averageRating == null
                                            ? 'No reviews yet • $experienceCountLabel'
                                            : '★ ${averageRating.toStringAsFixed(1)} • $experienceCountLabel',
                                        style: AppTextStyles.caption,
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(0, 36),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.sm,
                                    ),
                                  ),
                                  onPressed: () {
                                    followedOrganizations.remove(organization.id);
                                  },
                                  child: const Text('Unfollow'),
                                ),
                              ],
                            ),
                          ),
                        ),
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
