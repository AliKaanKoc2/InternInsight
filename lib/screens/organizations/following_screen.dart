import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/followed_organizations.dart';
import '../../core/routes/app_routes.dart';

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

            return ListView.separated(
              padding: AppSpacing.screen,
              itemCount: organizations.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: AppSpacing.sm);
              },
              itemBuilder: (context, index) {
                final organization = organizations[index];

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organization.name,
                          style: AppTextStyles.heading,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${organization.type} • ${organization.industry}',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          organization.location,
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                            onPressed: () {
                              followedOrganizations.remove(organization.id);
                            },
                            child: const Text('Unfollow'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
