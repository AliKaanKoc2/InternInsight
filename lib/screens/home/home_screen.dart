import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../data/models/experience.dart';
import '../../widgets/experience_card.dart';


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

  List<Experience> get _filteredExperiences {
    final experiences = List<Experience>.of(mockExperiences); //List.of generates copy for not to change original mock list

    if (_selectedFilter == 'Top rated') {
      experiences.sort(
            (a, b) => b.rating.compareTo(a.rating),
      );
    } else {
      experiences.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );
    }

    if (_selectedFilter == 'Verified') {
      return experiences
          .where((experience) => experience.isVerified)
          .toList();
    }

    return experiences;
  }

  @override
  Widget build(BuildContext context) {
    final experiences = _filteredExperiences;

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