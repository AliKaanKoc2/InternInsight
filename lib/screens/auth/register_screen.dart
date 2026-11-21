import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration form is valid.')),
      );
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Major'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your major.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Graduation year'),
                validator: (value) {
                  final input = (value ?? '').trim();
                  final year = int.tryParse(input);
                  if (input.length != 4 || year == null || year < 1000) {
                    return 'Enter a four-digit graduation year.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create account'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
