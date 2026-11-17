import 'package:flutter/material.dart';
import 'package:intern_insight/core/theme/app_spacing.dart';

class OrganizationListScreen extends StatefulWidget {
  const OrganizationListScreen({super.key});

  @override
  State<OrganizationListScreen> createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen> {
  int _selectedTab = 0;
  String _selectedType = 'All';

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
                    selected: _selectedType == 'All',
                    onSelected: (_) {
                      setState(() {
                        _selectedType = 'All';
                      });
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Company University Research chips here
                ],
              ),
            ),
            Expanded(
              child: Center(child: Text('Showing tab: $_selectedTab')),
            ),
          ],
        ),
      ),
    );
  }
}