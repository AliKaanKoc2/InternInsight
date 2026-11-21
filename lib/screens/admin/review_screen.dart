import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_verification_requests.dart';
import '../../data/models/verification_request.dart';

class ReviewScreen extends StatelessWidget {
  final VerificationRequest? request;

  const ReviewScreen({super.key, this.request});

  @override
  Widget build(BuildContext context) {
    // opened from 14 with a request, falls back to the first one
    final current = request ?? mockVerificationRequests.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Review request')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle, size: 40),
            title: Text(current.studentName, style: AppTextStyles.heading),
            subtitle: Text(
              '${current.studentInfo} · Submitted ${current.submittedAt}',
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}