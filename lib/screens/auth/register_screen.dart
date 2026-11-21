import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _majors = [
    'Computer Science and Engineering',
    'Electronics Engineering',
    'Industrial Engineering',
    'Management',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  final _graduationYears = List.generate(
    7,
    (index) => DateTime.now().year + index,
  );

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Confirm registration'),
          content: const Text('Confirm to return to Login.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
    if (mounted && confirmed == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppSpacing.screen,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your full name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@sabanciuniv.edu',
                ),
                validator: (value) {
                  final email = (value ?? '').trim().toLowerCase();
                  final parts = email.split('@');
                  if (parts.length != 2 ||
                      parts[0].isEmpty ||
                      parts[0].contains(' ') ||
                      parts[1] != 'sabanciuniv.edu') {
                    return 'Enter a valid Sabancı email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Use at least 8 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Major'),
                items: [
                  for (final major in _majors)
                    DropdownMenuItem(
                      value: major,
                      child: Text(major, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: (_) {},
                validator: (value) =>
                    value == null ? 'Select your major.' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<int>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Graduation year'),
                items: [
                  for (final year in _graduationYears)
                    DropdownMenuItem(value: year, child: Text('$year')),
                ],
                onChanged: (_) {},
                validator: (value) =>
                    value == null ? 'Select your graduation year.' : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create account'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
