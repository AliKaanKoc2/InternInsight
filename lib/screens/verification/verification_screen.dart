import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../data/mock_data.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify internship')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          Form(
            key: _formKey,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Internship'),
              hint: const Text('Select an internship'),
              items: [
                for (final experience in mockExperiences)
                  DropdownMenuItem(
                    value: experience.id,
                    child: Text(
                      '${experience.company} · ${experience.position}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (_) {},
              validator: (value) =>
              value == null ? 'Select the internship to verify.' : null,
            ),
          ),
        ],
      ),
    );
  }
}