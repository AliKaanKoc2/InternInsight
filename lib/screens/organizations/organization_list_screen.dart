import 'package:flutter/material.dart';
import 'package:intern_insight/core/theme/app_spacing.dart';

class OrganizationListScreen extends StatefulWidget {
  const OrganizationListScreen({super.key});

  @override
  State<OrganizationListScreen> createState() => _OrganizationListScreenState();
}

class _OrganizationListScreenState extends State<OrganizationListScreen>{
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organizations')),
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
            child: Center(child: Text('Showing: $_selectedType')),
          ),
        ],
      ),
    );
  }
}
