import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_organizations.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _stepOneKey = GlobalKey<FormState>();
  final _stepTwoKey = GlobalKey<FormState>();
  int _step = 0;
  bool _anonymous = false;
  int _rating = 0;
  bool _showRatingError = false;
  final List<String> _technologies = ['Python', 'SQL'];
  final _techController = TextEditingController();

  @override
  void dispose() {
    _techController.dispose();
    super.dispose();
  }

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
  final List<String> _cities = ['Istanbul', 'Ankara', 'Izmir', 'Kocaeli', 'Other'];
  final List<String> _workTypes = ['On-site', 'Hybrid', 'Remote'];
  final List<String> _currencies = ['TRY', 'USD', 'EUR'];
  final List<String> _channels = ['Career site', 'LinkedIn', 'Referral', 'University', 'Other'];
  final List<String> _interviewTypes = ['Technical', 'HR', 'Case study', 'Mixed'];
  final List<String> _difficulties = ['1/5', '2/5', '3/5', '4/5', '5/5'];

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
      return 'Year: 2000-2030.';
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

  Widget _dropdown(String label, List<String> items, {String? initial}) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      initialValue: initial,
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

  void _addTechnology() {
    _techController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add technology'),
          content: TextField(
            controller: _techController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'e.g. Flutter'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final tech = _techController.text.trim();
                if (tech.isNotEmpty && !_technologies.contains(tech)) {
                  setState(() {
                    _technologies.add(tech);
                  });
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _submit() {
    final formValid = _stepTwoKey.currentState!.validate();
    setState(() {
      _showRatingError = _rating == 0;
    });
    if (!formValid || _rating == 0) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Share this internship?'),
          content: const Text(
            'Your post will be published as unverified. '
                'You can request verification later from your profile.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _stepOneKey.currentState!.reset();
                _stepTwoKey.currentState!.reset();
                setState(() {
                  _step = 0;
                  _rating = 0;
                  _anonymous = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post published')),
                );
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
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
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _dropdown('Country', ['Turkey', 'Other'], initial: 'Turkey'),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _dropdown('City', _cities)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _dropdown('Working type', _workTypes, initial: 'On-site')),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Salary (optional)',
                    hintText: 'Amount',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Currency'),
            hint: const Text('Select'),
            items: [
              for (final currency in _currencies)
                DropdownMenuItem(value: currency, child: Text(currency)),
            ],
            onChanged: (_) {},
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Project description',
              hintText: 'Your tasks and what was expected from you',
              alignLabelWithHint: true,
            ),
            validator: _required,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Expanded(
                child: Text('Post anonymously', style: AppTextStyles.body),
              ),
              Switch(
                value: _anonymous,
                onChanged: (value) {
                  setState(() {
                    _anonymous = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepTwo() {
    return Form(
      key: _stepTwoKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Review', style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Expanded(
                child: Text('Overall rating', style: AppTextStyles.body),
              ),
              for (int i = 1; i <= 5; i++)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    setState(() {
                      _rating = i;
                      _showRatingError = false;
                    });
                  },
                  icon: Icon(
                    i <= _rating ? Icons.star : Icons.star_border,
                    color: AppColors.warning,
                  ),
                ),
            ],
          ),
          if (_showRatingError)
            const Text(
              'Give a rating.',
              style: TextStyle(fontSize: 12, color: AppColors.error),
            ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Comment',
              hintText: 'How was your internship?',
              alignLabelWithHint: true,
            ),
            validator: _required,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Pros (optional)',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Cons (optional)',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Interview process', style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _dropdown('Applied via', _channels)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Rounds',
                    hintText: 'e.g. 2',
                  ),
                  validator: (value) {
                    final rounds = int.tryParse(value ?? '');
                    if (rounds == null || rounds < 1 || rounds > 10) {
                      return 'Enter 1-10.';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _dropdown('Interview type', _interviewTypes)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: _dropdown('Difficulty', _difficulties)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Technologies', style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              for (final tech in _technologies)
                Chip(
                  label: Text(tech),
                  onDeleted: () {
                    setState(() {
                      _technologies.remove(tech);
                    });
                  },
                ),
              ActionChip(
                avatar: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
                onPressed: _addTechnology,
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
          Offstage(offstage: _step != 1, child: _buildStepTwo()),
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
                    onPressed: _submit,
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