import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/mock_organizations.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _stepOneKey = GlobalKey<FormState>();
  int _step = 0;

  final List<String> _departments = [
    'Software',
    'Data',
    'R&D',
    'Hardware',
    'Product',
    'Marketing',
    'HR',
    'Other',
  ];

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _date(String? value) {
    final parts = (value ?? '').trim().split('/');
    if (parts.length != 3) {
      return 'Use dd/mm/yyyy.';
    }
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null || parts[2].length != 4) {
      return 'Use dd/mm/yyyy.';
    }
    if (month < 1 || month > 12) {
      return 'Month must be 1-12.';
    }
    if (day < 1 || day > 31) {
      return 'Day must be 1-31.';
    }
    if (year < 2000 || year > 2030) {
      return 'Enter a year between 2000 and 2030.';
    }
    return null;
  }

  String? _select(String? value) {
    return value == null ? 'Select one.' : null;
  }

  Widget _stepLabel(String text, bool active) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      hint: const Text('Select'),
      items: [
        for (final item in items)
          DropdownMenuItem(
            value: item,
            child: Text(item, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: (_) {},
      validator: _select,
    );
  }

  Widget _buildStepOne() {
    return Form(
      key: _stepOneKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Organization'),
            hint: const Text('Select organization'),
            items: [
              for (final organization in mockOrganizations)
                DropdownMenuItem(
                  value: organization.id,
                  child: Text(organization.name),
                ),
            ],
            onChanged: (_) {},
            validator: _select,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _dropdown('Department', _departments)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Role title',
                    hintText: 'e.g. SW Intern',
                  ),
                  validator: _required,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Start date',
                    hintText: 'dd/mm/yyyy',
                  ),
                  validator: _date,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'End date',
                    hintText: 'dd/mm/yyyy',
                  ),
                  validator: _date,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share an internship')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _stepLabel('1. Internship', _step == 0),
                _stepLabel('2. Review', _step == 1),
                _stepLabel('3. Interview', _step == 1),
                _stepLabel('4. Tech', _step == 1),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Offstage(offstage: _step != 0, child: _buildStepOne()),
          if (_step == 1) const Text('Step 2-4 fields'),
          const SizedBox(height: AppSpacing.lg),
          if (_step == 0)
            ElevatedButton(
              onPressed: () {
                if (_stepOneKey.currentState!.validate()) {
                  setState(() {
                    _step = 1;
                  });
                }
              },
              child: const Text('Next'),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _step = 0;
                      });
                    },
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}