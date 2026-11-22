import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_data.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fileName;
  bool _showFileError = false;

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

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Request submitted')));
    Navigator.pop(context);
  }

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
        ],
      ),
    );
  }
}