import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppSpacing.screen,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Image.asset('assets/images/logo.png', height: 72),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'InternInsight',
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Real internship experiences from students',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@sabanciuniv.edu',
                ),
                validator: (value) {
                  final parts = (value ?? '').trim().toLowerCase().split('@');
                  if (parts.length != 2 ||
                      parts[0].isEmpty ||
                      parts[0].contains(' ') ||
                      parts[1] != 'sabanciuniv.edu') {
                    return 'Enter a valid Sabancı email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(onPressed: _logIn, child: const Text('Log in')),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Forgot password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text.rich(
                  TextSpan(
                    text: 'No account? ',
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
