import 'package:flutter/material.dart';
import 'package:intern_insight/core/theme/app_spacing.dart';

import '../../data/mock_verification_requests.dart';
import '../../data/models/verification_request.dart';
import 'review_screen.dart';
import '../../core/theme/app_colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedTab = 0;
  final List<String> _tabStatuses = ['Pending', 'Approved', 'Rejected'];

  List<VerificationRequest> get _filteredRequests {
    final status = _tabStatuses[_selectedTab];
    final List<VerificationRequest> result = [];

    for (final request in mockVerificationRequests) {
      if (request.status == status) {
        result.add(request);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verification requests'),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: ListView.builder(
          padding: AppSpacing.screen,
          itemCount: _filteredRequests.length,
          itemBuilder: (context, index) {
            final request = _filteredRequests[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(request.studentName),
                  subtitle: Text(
                    '${request.organizationName} · ${request.role}\nSubmitted ${request.submittedAt}',
                  ),
                  isThreeLine: true,
                  trailing: const Text(
                    'Review ›',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => ReviewScreen(request: request),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
