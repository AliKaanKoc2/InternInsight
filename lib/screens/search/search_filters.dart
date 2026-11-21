import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../data/mock_organizations.dart';
import '../../data/models/experience.dart';

String _cityOf(Experience experience) =>
    experience.location.split(',').first.trim();
String _countryOf(Experience experience) =>
    experience.location.split(',').last.trim();

class SearchFilterValues {
  static const defaultRating = RangeValues(3, 5);

  final List<String> organizationTypes;
  final List<String> industries;
  final List<String> technologies;
  String country;
  String city;
  String workType;
  RangeValues rating;
  bool verifiedOnly;

  SearchFilterValues({
    List<String> organizationTypes = const [],
    List<String> industries = const [],
    List<String> technologies = const [],
    this.country = '',
    this.city = '',
    this.workType = '',
    this.rating = defaultRating,
    this.verifiedOnly = false,
  }) : organizationTypes = List.of(organizationTypes),
       industries = List.of(industries),
       technologies = List.of(technologies);

  SearchFilterValues.copy(SearchFilterValues other)
    : this(
        organizationTypes: other.organizationTypes,
        industries: other.industries,
        technologies: other.technologies,
        country: other.country,
        city: other.city,
        workType: other.workType,
        rating: other.rating,
        verifiedOnly: other.verifiedOnly,
      );

  bool matches(Experience experience) {
    if ((verifiedOnly && !experience.isVerified) ||
        (country.isNotEmpty && country != _countryOf(experience)) ||
        (city.isNotEmpty && city != _cityOf(experience)) ||
        (workType.isNotEmpty && workType != experience.workType) ||
        (technologies.isNotEmpty &&
            !technologies.any(experience.technologies.contains)) ||
        (rating != defaultRating &&
            (experience.rating < rating.start ||
                experience.rating > rating.end))) {
      return false;
    }

    if (organizationTypes.isEmpty && industries.isEmpty) return true;

    for (final organization in mockOrganizations) {
      if (organization.id == experience.organizationId) {
        final type = organization.type == 'Research Institute'
            ? 'Research'
            : organization.type;
        return (organizationTypes.isEmpty ||
                organizationTypes.contains(type)) &&
            (industries.isEmpty || industries.contains(organization.industry));
      }
    }
    return false;
  }
}

List<Chip> buildSearchFilterChips(
  SearchFilterValues filters,
  void Function(VoidCallback) applyChange,
) {
  Chip removable(String label, VoidCallback remove) {
    return Chip(label: Text(label), onDeleted: () => applyChange(remove));
  }

  return [
    for (final type in filters.organizationTypes)
      removable(type, () => filters.organizationTypes.remove(type)),
    if (filters.country.isNotEmpty)
      removable(filters.country, () => filters.country = ''),
    if (filters.city.isNotEmpty)
      removable(filters.city, () => filters.city = ''),
    for (final industry in filters.industries)
      removable(industry, () => filters.industries.remove(industry)),
    for (final technology in filters.technologies)
      removable(technology, () => filters.technologies.remove(technology)),
    if (filters.workType.isNotEmpty)
      removable(filters.workType, () => filters.workType = ''),
    if (filters.rating != SearchFilterValues.defaultRating)
      removable(
        'Rating ${filters.rating.start.toStringAsFixed(1)}–${filters.rating.end.toStringAsFixed(1)}',
        () => filters.rating = SearchFilterValues.defaultRating,
      ),
    if (filters.verifiedOnly)
      removable('Verified only', () => filters.verifiedOnly = false),
  ];
}

class SearchFilters extends StatefulWidget {
  const SearchFilters({
    super.key,
    required this.initialValues,
    required this.countMatches,
  });

  final SearchFilterValues initialValues;
  final int Function(SearchFilterValues) countMatches;

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  late SearchFilterValues _draft;
  final _technologyController = TextEditingController();
  final _countries = {for (final item in mockExperiences) _countryOf(item)};
  final _industries = {for (final org in mockOrganizations) org.industry};
  final _technologies = {
    for (final item in mockExperiences) ...item.technologies,
  };

  @override
  void initState() {
    super.initState();
    _draft = SearchFilterValues.copy(widget.initialValues);
  }

  @override
  void dispose() {
    _technologyController.dispose();
    super.dispose();
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(label, style: AppTextStyles.label),
    );
  }

  Widget _multiSelectChips({
    required Iterable<String> options,
    required List<String> selected,
    String? clearLabel,
  }) {
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        if (clearLabel != null)
          ChoiceChip(
            label: Text(clearLabel),
            selected: selected.isEmpty,
            onSelected: (_) => setState(selected.clear),
          ),
        for (final option in options)
          FilterChip(
            label: Text(option),
            selected: selected.contains(option),
            onSelected: (enabled) {
              setState(() {
                if (enabled) {
                  selected.add(option);
                } else {
                  selected.remove(option);
                }
              });
            },
          ),
      ],
    );
  }

  Widget _locationDropdown(
    String label,
    String value,
    Iterable<String> options,
    ValueChanged<String> onChanged,
  ) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          items: [
            const DropdownMenuItem(value: '', child: Text('Any')),
            for (final option in options)
              DropdownMenuItem(
                value: option,
                child: Text(option, overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (choice) {
            if (choice != null) {
              setState(() {
                onChanged(choice);
              });
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.countMatches(_draft);
    final cities = {
      for (final item in mockExperiences)
        if (_draft.country.isEmpty || _countryOf(item) == _draft.country)
          _cityOf(item),
    };
    final technologyQuery = _technologyController.text.trim().toLowerCase();
    final matchingTechnologies = _technologies.where(
      (technology) => technology.toLowerCase().contains(technologyQuery),
    );
    final heading = Row(
      children: [
        const Expanded(child: Text('Filters', style: AppTextStyles.heading)),
        IconButton(
          tooltip: 'Close filters',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
    final fields = <Widget>[
      _sectionLabel('Organization type'),
      _multiSelectChips(
        options: const ['Company', 'University', 'Research'],
        selected: _draft.organizationTypes,
        clearLabel: 'All',
      ),
      const SizedBox(height: AppSpacing.md),
      _sectionLabel('Location'),
      Row(
        children: [
          Expanded(
            child: _locationDropdown('Country', _draft.country, _countries, (
              value,
            ) {
              if (value != _draft.country) {
                _draft.country = value;
                _draft.city = '';
              }
            }),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _locationDropdown('City', _draft.city, cities, (value) {
              _draft.city = value;
            }),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      _sectionLabel('Industry'),
      _multiSelectChips(
        options: _industries,
        selected: _draft.industries,
        clearLabel: 'Any',
      ),
      const SizedBox(height: AppSpacing.md),
      _sectionLabel('Technologies'),
      TextField(
        controller: _technologyController,
        decoration: const InputDecoration(
          hintText: 'Search technologies',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (_) => setState(() {}),
      ),
      if (matchingTechnologies.isEmpty)
        const Padding(
          padding: EdgeInsets.only(top: AppSpacing.sm),
          child: Text('No matching technologies.'),
        )
      else
        _multiSelectChips(
          options: matchingTechnologies,
          selected: _draft.technologies,
        ),
      const SizedBox(height: AppSpacing.md),
      _sectionLabel('Working type'),
      Wrap(
        spacing: AppSpacing.sm,
        children: [
          for (final option in ['', 'On-site', 'Hybrid', 'Remote'])
            ChoiceChip(
              label: Text(option.isEmpty ? 'Any' : option),
              selected: _draft.workType == option,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _draft.workType = option;
                  });
                }
              },
            ),
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      _sectionLabel(
        'Rating ${_draft.rating.start.toStringAsFixed(1)}–${_draft.rating.end.toStringAsFixed(1)}',
      ),
      RangeSlider(
        values: _draft.rating,
        min: 3,
        max: 5,
        divisions: 20,
        labels: RangeLabels(
          _draft.rating.start.toStringAsFixed(1),
          _draft.rating.end.toStringAsFixed(1),
        ),
        onChanged: (value) {
          setState(() {
            _draft.rating = value;
          });
        },
      ),
      Row(
        children: [
          const Expanded(child: Text('Verified only')),
          Switch(
            value: _draft.verifiedOnly,
            onChanged: (value) {
              setState(() {
                _draft.verifiedOnly = value;
              });
            },
          ),
        ],
      ),
    ];
    final actions = Row(
      children: [
        TextButton(
          onPressed: () {
            _technologyController.clear();
            setState(() {
              _draft = SearchFilterValues();
            });
          },
          child: const Text('Reset'),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, _draft),
            child: Text(count == 1 ? 'Show 1 result' : 'Show $count results'),
          ),
        ),
      ],
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: AppSpacing.screen,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxHeight < 160) {
              return ListView(children: [heading, ...fields, actions]);
            }
            return Column(
              children: [
                heading,
                Expanded(child: ListView(children: fields)),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}
