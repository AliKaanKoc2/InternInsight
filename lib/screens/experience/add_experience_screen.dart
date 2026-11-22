import 'package:flutter/material.dart';
import 'package:intern_insight/core/theme/app_spacing.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share an internship')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Text(_step == 0 ? 'Step 1 fields' : 'Step 2-4 fields'),
        ],
      )
    );
  }
}
