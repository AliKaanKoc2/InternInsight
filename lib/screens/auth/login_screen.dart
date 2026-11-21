import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
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
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'name@sabanciuniv.edu',
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: const Text('Log in'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
