import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_verification_requests.dart';
import '../../data/models/verification_request.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_data.dart';
import '../../data/models/experience.dart';

class ReviewScreen extends StatefulWidget {
  final VerificationRequest? request;

  const ReviewScreen({super.key, this.request});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  // "Are you sure?" dialog, used by both Approve and Reject
  void _confirm(String action) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text(
            action == 'Approve'
                ? 'The post will get the verified badge.'
                : 'The student will see your reason in My requests.',
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      action == 'Approve'
                          ? 'Request approved'
                          : 'Request rejected',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }

  void _reject() {
    // reason is required only for reject
    if (_formKey.currentState!.validate()) {
      _confirm('Reject');
    }
  }

  void _openDocument(String fileName) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(fileName),
          content: Container(
            height: 320,
            color: AppColors.border,
            child: const Center(
              child: Icon(
                Icons.description_outlined,
                size: 64,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // opened from 14 with a request, falls back to the first one
    final current = widget.request ?? mockVerificationRequests.first;
    final isPending = current.status == 'Pending';

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
          const SizedBox(height: AppSpacing.sm),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Post being verified', style: AppTextStyles.label),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${current.organizationName} · ${current.department}',
                    style: AppTextStyles.heading,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${current.role} · ${current.period}',
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () {
                      // mock: open the post of the same company, or the first one
                      Experience post = mockExperiences.first;
                      for (final experience in mockExperiences) {
                        if (experience.company == current.organizationName) {
                          post = experience;
                        }
                      }
                      Navigator.pushNamed(
                        context,
                        AppRoutes.experienceDetail,
                        arguments: post,
                      );
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text(
                      'View post ›',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // document
          const Text('Document', style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.description_outlined,
                size: 40,
                color: AppColors.primary,
              ),
              title: Text(current.documentName),
              subtitle: const Text('Press to open full screen'),
              onTap: () {
                _openDocument(current.documentName);
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          if (isPending)
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Reason (required to reject)',
                      hintText: 'e.g. document does not match the post',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Write a reason to reject this request.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _reject,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _confirm('Approve');
                          },
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Text(
              'This request was ${current.status.toLowerCase()}.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
