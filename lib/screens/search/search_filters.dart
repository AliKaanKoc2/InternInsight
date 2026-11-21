import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/experience.dart';

class SearchFilterValues {
  bool verifiedOnly;

  SearchFilterValues({this.verifiedOnly = false});

  SearchFilterValues.copy(SearchFilterValues other)
    : this(verifiedOnly: other.verifiedOnly);

  bool matches(Experience experience) {
    return !verifiedOnly || experience.isVerified;
  }
}

List<Chip> buildSearchFilterChips(
  SearchFilterValues filters,
  void Function(VoidCallback) applyChange,
) {
  return [
    if (filters.verifiedOnly)
      Chip(
        label: const Text('Verified only'),
        onDeleted: () => applyChange(() => filters.verifiedOnly = false),
      ),
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

  @override
  void initState() {
    super.initState();
    _draft = SearchFilterValues.copy(widget.initialValues);
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.countMatches(_draft);
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
