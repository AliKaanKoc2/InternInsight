import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _confirming = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _confirming = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Form(
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
                    decoration: const InputDecoration(
                      labelText: 'Graduation year',
                    ),
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
            if (_confirming)
              Container(
                color: Colors.black54,
                padding: AppSpacing.screen,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 360),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radius),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Confirm registration',
                            style: AppTextStyles.heading,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Text('Confirm to return to Login.'),
                          const SizedBox(height: AppSpacing.md),
                          Wrap(
                            spacing: AppSpacing.sm,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _confirming = false;
                                  });
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
