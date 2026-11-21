import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../data/mock_organizations.dart';
import '../../data/models/experience.dart';
import '../../data/saved_experiences.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is! Experience) {
      return Scaffold(
        appBar: AppBar(title: const Text('Experience')),
        body: const Center(child: Text('No experience selected.')),
      );
    }

    final experience = arguments;
    final organization = mockOrganizations
        .where((org) => org.id == experience.organizationId)
        .firstOrNull;

    final similarExperiences = mockExperiences
        .where((other) =>
    other.id != experience.id &&
        other.technologies.any(experience.technologies.contains))
        .take(2)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Experience', style: AppTextStyles.title),
        actions: [
          ListenableBuilder(
            listenable: savedExperiences,
            builder: (context, child) {
              final isSaved = savedExperiences.contains(experience.id);

              return IconButton(
                tooltip: isSaved ? 'Remove from saved' : 'Save experience',
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: AppColors.primary,
                ),
                onPressed: () => savedExperiences.toggle(experience),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: organization == null
                    ? null
                    : () => Navigator.pushNamed(
                  context,
                  AppRoutes.organizationDetail,
                  arguments: organization,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${experience.company} · ${experience.department}',
                          style: AppTextStyles.heading.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (organization != null)
                        const Icon(Icons.chevron_right, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              Text(experience.position, style: AppTextStyles.title),
              if (experience.isVerified) ...[
                const SizedBox(height: AppSpacing.sm),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    avatar: Icon(Icons.verified, size: 18, color: AppColors.success),
                    label: Text('Verified'),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              _InfoLine(
                icon: Icons.location_on_outlined,
                text: '${experience.location} • ${experience.workType}',
              ),
              const SizedBox(height: AppSpacing.sm),
              _InfoLine(
                icon: Icons.calendar_month_outlined,
                text: experience.duration,
              ),

              const _SectionTitle('Overall experience'),
              _InfoLine(
                icon: Icons.star,
                color: AppColors.warning,
                text: '${experience.rating.toStringAsFixed(1)} / 5',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                experience.recommends
                    ? 'I would recommend this internship.'
                    : 'I would not recommend this internship.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text('My review', style: AppTextStyles.heading),
              const SizedBox(height: AppSpacing.sm),
              Text(experience.review, style: AppTextStyles.body),
              const SizedBox(height: AppSpacing.md),

              LayoutBuilder(
                builder: (context, constraints) {
                  final pros = _ReviewList(title: 'Pros', items: experience.pros);
                  final cons = _ReviewList(title: 'Cons', items: experience.cons);

                  if (constraints.maxWidth < 320) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        pros,
                        const SizedBox(height: AppSpacing.sm),
                        cons,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: pros),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: cons),
                    ],
                  );
                },
              ),

              const _SectionTitle('Interview process'),
              Text(
                'Application channel: ${experience.applicationChannel}',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Rounds: ${experience.interviewRounds} • '
                    'Difficulty: ${experience.interviewDifficulty}',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(experience.interviewDescription, style: AppTextStyles.body),

              if (experience.technologies.isNotEmpty) ...[
                const _SectionTitle('Technologies used'),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final technology in experience.technologies)
                      Chip(label: Text(technology)),
                  ],
                ),
              ],

              if (similarExperiences.isNotEmpty) ...[
                const _SectionTitle('Similar experiences'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final similar in similarExperiences)
                        Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: SizedBox(
                            width: 220,
                            child: Card(
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.experienceDetail,
                                  arguments: similar,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(similar.company, style: AppTextStyles.label),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(similar.position, style: AppTextStyles.body),
                                      const SizedBox(height: AppSpacing.sm),
                                      _InfoLine(
                                        icon: Icons.star,
                                        color: AppColors.warning,
                                        text: '${similar.rating.toStringAsFixed(1)} / 5',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        const Divider(color: AppColors.border),
        const SizedBox(height: AppSpacing.sm),
        Text(title, style: AppTextStyles.heading),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.text,
    this.color = AppColors.textSecondary,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTextStyles.body)),
      ],
    );
  }
}

class _ReviewList extends StatelessWidget {
  const _ReviewList({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.sm),
            if (items.isEmpty)
              const Text('None listed.', style: AppTextStyles.caption)
            else
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text('• $item', style: AppTextStyles.body),
                ),
          ],
        ),
      ),
    );
  }
}