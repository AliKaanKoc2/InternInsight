import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/followed_organizations.dart';
import '../../data/mock_data.dart';
import '../../data/mock_organizations.dart';
import '../../data/models/experience.dart';
import '../../data/models/organization.dart';
import '../../widgets/experience_card.dart';

class OrganizationDetailScreen extends StatefulWidget {
  const OrganizationDetailScreen({super.key});

  @override
  State<OrganizationDetailScreen> createState() =>
      _OrganizationDetailScreenState();
}

class _OrganizationDetailScreenState extends State<OrganizationDetailScreen> {
  String? _selectedDepartment;

  String _websiteOf(Organization organization) {
    final slug = organization.name
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('.', '');
    return '$slug.com';
  }

  int _difficultyOf(String difficulty) {
    if (difficulty == 'Easy') return 2;
    if (difficulty == 'Challenging') return 4;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final organization = arguments is Organization
        ? arguments
        : mockOrganizations.first;

    final List<Experience> experiences = [];
    for (final experience in mockExperiences) {
      if (experience.organizationId == organization.id) {
        experiences.add(experience);
      }
    }

    final Map<String, int> departments = {};
    for (final experience in experiences) {
      departments[experience.department] =
          (departments[experience.department] ?? 0) + 1;
    }

    final List<Experience> shown = [];
    for (final experience in experiences) {
      if (_selectedDepartment == null ||
          experience.department == _selectedDepartment) {
        shown.add(experience);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(organization.name)),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
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
          const SizedBox(height: AppSpacing.md),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: experiences.isEmpty
                  ? const Text(
                      'No reviews yet for this organization.',
                      style: AppTextStyles.caption,
                    )
                  : _buildOverview(organization, experiences),
            ),
          ),

          if (departments.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            const Text('Departments', style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.sm),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final department in departments.keys)
                    _buildDepartmentCard(department, departments[department]!),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final experience in shown)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ExperienceCard(
                  experience: experience,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.experienceDetail,
                      arguments: experience,
                    );
                  },
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverview(
    Organization organization,
    List<Experience> experiences,
  ) {
    final List<String> topTech = [];
    for (final experience in experiences) {
      for (final tech in experience.technologies) {
        if (!topTech.contains(tech) && topTech.length < 3) {
          topTech.add(tech);
        }
      }
    }

    final first = experiences.first;
    final difficulty = _difficultyOf(first.interviewDifficulty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: Text('Overview', style: AppTextStyles.label)),
            const Icon(Icons.star, size: 16, color: AppColors.warning),
            Text(' ${organization.rating}', style: AppTextStyles.label),
            Text(
              '  avg. of ${experiences.length} reviews',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const Text('Top tech', style: AppTextStyles.caption),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [for (final tech in topTech) Chip(label: Text(tech))],
              ),
            ),
          ],
        ),
        const Divider(height: AppSpacing.lg),
        const Text('Interview summary', style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        _summaryRow('Usually applied via', first.applicationChannel),
        _summaryRow('Common interviews', '~${first.interviewRounds} rounds'),
        Row(
          children: [
            const Expanded(
              child: Text('Avg. difficulty', style: AppTextStyles.caption),
            ),
            for (int i = 1; i <= 5; i++)
              Container(
                width: 16,
                height: 6,
                margin: const EdgeInsets.only(left: 3),
                color: i <= difficulty ? AppColors.primary : AppColors.border,
              ),
            const SizedBox(width: AppSpacing.sm),
            Text('$difficulty/5', style: AppTextStyles.label),
          ],
        ),
      ],
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyles.caption)),
          Text(value, style: AppTextStyles.label),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(String department, int reviewCount) {
    final isSelected = _selectedDepartment == department;
    return SizedBox(
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        child: ListTile(
          title: Text(department, style: AppTextStyles.label),
          subtitle: Text('$reviewCount reviews', style: AppTextStyles.caption),
          onTap: () {
            setState(() {
              _selectedDepartment = isSelected ? null : department;
            });
          },
        ),
      ),
    );
  }
}