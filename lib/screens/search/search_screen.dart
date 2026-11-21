import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';
import '../../data/models/experience.dart';
import '../../widgets/experience_card.dart';
import 'search_filters.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  String _sort = 'Most relevant';
  SearchFilterValues _filters = SearchFilterValues();

  List<Experience> _matchingExperiences(
    String query,
    SearchFilterValues filters,
  ) {
    return mockExperiences.where((experience) {
      final matchesQuery =
          experience.company.toLowerCase().contains(query) ||
          experience.position.toLowerCase().contains(query);
      return matchesQuery && filters.matches(experience);
    }).toList();
  }

  List<Experience> get _results {
    final query = _query.trim().toLowerCase();
    final results = _matchingExperiences(query, _filters);

    results.sort((a, b) {
      if (_sort == 'Top rated') {
        final byRating = b.rating.compareTo(a.rating);
        if (byRating != 0) return byRating;
      }
      if (_sort == 'Most relevant' && query.isNotEmpty) {
        final byRelevance = _relevance(
          b,
          query,
        ).compareTo(_relevance(a, query));
        if (byRelevance != 0) return byRelevance;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    return results;
  }

  int _relevance(Experience experience, String query) {
    final company = experience.company.toLowerCase();
    final position = experience.position.toLowerCase();
    if (company == query || position == query) return 2;
    if (company.startsWith(query) || position.startsWith(query)) return 1;
    return 0;
  }

  Future<void> _openFilters() async {
    final query = _query.trim().toLowerCase();
    final filters = await showModalBottomSheet<SearchFilterValues>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: FractionallySizedBox(
            heightFactor: 0.92,
            child: SearchFilters(
              initialValues: _filters,
              countMatches: (draft) =>
                  _matchingExperiences(query, draft).length,
            ),
          ),
        );
      },
    );
    if (mounted && filters != null) {
      setState(() {
        _filters = filters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final chips = buildSearchFilterChips(_filters, setState);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screen,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Organization or role',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: _openFilters,
                  child: Text(
                    chips.isEmpty ? 'Filters' : 'Filters ${chips.length}',
                  ),
                ),
              ],
            ),
            if (chips.isNotEmpty)
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: chips,
              ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  results.length == 1
                      ? '1 result'
                      : '${results.length} results',
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 228),
                  child: Row(
                    children: [
                      const Text('Sort:'),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: DropdownButton<String>(
                          value: _sort,
                          isExpanded: true,
                          items: [
                            for (final option in [
                              'Most relevant',
                              'Latest',
                              'Top rated',
                            ])
                              DropdownMenuItem(
                                value: option,
                                child: Text(
                                  option,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                          onChanged: (option) {
                            if (option != null) {
                              setState(() {
                                _sort = option;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (results.isEmpty) const Text('No matching experiences.'),
            for (final experience in results)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ExperienceCard(
                  key: ValueKey(experience.id),
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
        ),
      ),
    );
  }
}
