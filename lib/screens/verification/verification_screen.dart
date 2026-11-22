import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../data/mock_verification_requests.dart';
import '../../data/models/verification_request.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fileName;
  bool _showFileError = false;

  // mock: the logged-in student's requests
  final List<String> _myRequestIds = ['req_001', 'req_005', 'req_006'];

  List<VerificationRequest> get _myRequests {
    final List<VerificationRequest> result = [];
    for (final request in mockVerificationRequests) {
      if (_myRequestIds.contains(request.id)) {
        result.add(request);
      }
    }
    return result;
  }

  Color _statusColor(String status) {
    if (status == 'Approved') return AppColors.success;
    if (status == 'Rejected') return AppColors.error;
    return AppColors.warning;
  }

  // UI only for now: pressing the box pretends a file was picked
  void _pickFile() {
    setState(() {
      _fileName = 'internship_certificate.pdf';
      _showFileError = false;
    });
  }

  void _submit() {
    final formValid = _formKey.currentState!.validate();
    setState(() {
      _showFileError = _fileName == null;
    });
    if (!formValid || _fileName == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final requests = _myRequests;

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
          const SizedBox(height: AppSpacing.md),

          // upload box
          Card(
            child: ListTile(
              leading: Icon(
                _fileName == null
                    ? Icons.upload_file_outlined
                    : Icons.description_outlined,
                size: 40,
                color: AppColors.primary,
              ),
              title: Text(_fileName ?? 'Upload document'),
              subtitle: Text(
                _fileName == null ? 'PDF, JPG or PNG' : 'Press to change',
              ),
              onTap: _pickFile,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              _showFileError
                  ? 'Upload a document first.'
                  : 'e.g. internship certificate, acceptance email',
              style: _showFileError
                  ? const TextStyle(fontSize: 12, color: AppColors.error)
                  : AppTextStyles.caption,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit request'),
          ),
          const SizedBox(height: AppSpacing.xl),

          // my requests
          Row(
            children: [
              const Expanded(
                child: Text('My requests', style: AppTextStyles.heading),
              ),
              Text('${requests.length} total', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final request in requests)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(request.organizationName),
                  subtitle: Text(
                    '${request.role}\nSubmitted ${request.submittedAt}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    request.status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _statusColor(request.status),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}