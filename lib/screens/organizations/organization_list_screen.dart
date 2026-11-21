import 'package:flutter/material.dart';
import 'package:intern_insight/core/theme/app_colors.dart';
import 'package:intern_insight/core/theme/app_spacing.dart';
import 'package:intern_insight/data/mock_organizations.dart';
import 'package:intern_insight/data/models/organization.dart';
import 'package:intern_insight/widgets/organization_card.dart';

class OrganizationListScreen extends StatefulWidget {
  const OrganizationListScreen({super.key});

  @override
  State<OrganizationListScreen> createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen> {
  int _selectedTab = 0;
  final Set<String> _selectedIndustries = {};
  final List<String> _industries = ['Software', 'Artificial Intelligence', 'Mobile Development', 'Finance', 'Gaming', 'Health', 'Defense', 'Automotive', 'Consulting', 'Education'];
  final List<String> _tabTypes = ['All', 'Company', 'University', 'Research'];

  List<Organization> get _filteredOrganizations {
    final type = _tabTypes[_selectedTab];
    final List<Organization> result = [];

    for (final org in mockOrganizations) {
      final typeMatches = (type == 'All' || org.type == type);
      final industryMatches = (_selectedIndustries.isEmpty || _selectedIndustries.contains(org.industry));

      if (typeMatches && industryMatches) {
        result.add(org);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Organizations'),
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Companies'),
              Tab(text: 'Universities'),
              Tab(text: 'Research'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: AppSpacing.screen,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedIndustries.isEmpty,
                    onSelected: (_) {
                      setState(() {
                        _selectedIndustries.clear();
                      });
                    },
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: AppColors.border,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final industry in _industries) ...[
                            ChoiceChip(
                              label: Text(industry),
                              selected: _selectedIndustries.contains(industry),
                              onSelected: (_) {
                                setState(() {
                                  if (_selectedIndustries.contains(industry)) {
                                    _selectedIndustries.remove(industry);
                                  } else {
                                    _selectedIndustries.add(industry);
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: AppSpacing.sm),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: AppSpacing.screen,
                itemCount: _filteredOrganizations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: OrganizationCard(
                      organization: _filteredOrganizations[index],
                    ),
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