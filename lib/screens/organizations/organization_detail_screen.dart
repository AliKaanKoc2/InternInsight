import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/followed_organizations.dart';
import '../../data/mock_organizations.dart';
import '../../data/models/organization.dart';

class OrganizationDetailScreen extends StatelessWidget {
  const OrganizationDetailScreen({super.key});

  // mock website from the name, example: "Defense Co." -> defenseco.com
  String _websiteOf(Organization organization) {
    final slug = organization.name
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('.', '');
    return '$slug.com';
  }

  @override
  Widget build(BuildContext context) {
    // opened from 05, 07 and 11 with the organization as argument
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final organization = arguments is Organization
        ? arguments
        : mockOrganizations.first;

    return Scaffold(
      appBar: AppBar(title: Text(organization.name)),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          // header
          Row(
            children: [
              Image.network(organization.logoUrl, width: 64, height: 64),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(organization.name, style: AppTextStyles.title),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${organization.industry} · ${organization.location}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _websiteOf(organization),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          ListenableBuilder(
            listenable: followedOrganizations,
            builder: (context, child) {
              final isFollowing = followedOrganizations.contains(
                organization.id,
              );
              if (isFollowing) {
                return OutlinedButton(
                  onPressed: () {
                    followedOrganizations.toggle(organization);
                  },
                  child: const Text('Following'),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  followedOrganizations.toggle(organization);
                },
                child: const Text('Follow'),
              );
            },
          ),
        ],
      ),
    );
  }
}
