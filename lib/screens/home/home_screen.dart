import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _filters = const [
    'Latest',
    'Top rated',
    'Verified',
  ];

  String _selectedFilter = 'Latest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'InternInsight',
          style: AppTextStyles.title,
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: (){
              Navigator.pushNamed(context, AppRoutes.search);
            },
          ),
          IconButton(
            tooltip: 'Saved experiences',
            icon: const Icon(Icons.bookmark_outline),
            onPressed: (){
              Navigator.pushNamed(context, AppRoutes.saved);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _filters.map((filter){
                  return ChoiceChip(
                    label: Text(filter),
                    selected : _selectedFilter == filter,
                    onSelected: (selected) {
                      if (selected) {
                        setState((){
                          _selectedFilter = filter;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  itemCount: mockExperiences.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: AppSpacing.sm);
                  },
                  itemBuilder: (context, index) {
                    final experience = mockExperiences[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.company,
                              style: AppTextStyles.heading,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}