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
  bool _showFilters = false;
  bool _verifiedOnly = false;

  List<Experience> get _results {
    final query = _query.trim().toLowerCase();
    final results = mockExperiences.where((experience) {
      final matchesQuery =
          experience.company.toLowerCase().contains(query) ||
          experience.position.toLowerCase().contains(query);
      return matchesQuery && (!_verifiedOnly || experience.isVerified);
    }).toList();

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

  void _setVerifiedOnly(bool value) {
    setState(() {
      _verifiedOnly = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
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
                  onPressed: () {
                    setState(() {
                      _showFilters = !_showFilters;
                    });
                  },
                  child: Text(_showFilters ? 'Hide filters' : 'Filters'),
                ),
              ],
            ),
            if (_showFilters)
              SearchFilters(
                verifiedOnly: _verifiedOnly,
                onVerifiedOnlyChanged: _setVerifiedOnly,
              ),
            if (_verifiedOnly)
              Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: const Text('Verified only'),
                  onDeleted: () => _setVerifiedOnly(false),
                ),
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
