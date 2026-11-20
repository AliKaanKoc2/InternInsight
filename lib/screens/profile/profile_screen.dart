import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../data/mock_data.dart';
import '../../widgets/experience_card.dart';
import '../../data/saved_experiences.dart';
import '../../data/followed_organizations.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Example Student';
  String _major = 'Computer Science';
  int _graduationYear = 2027;

  String get _initials {
    final words = _name.trim().split(RegExp(r'\s+'));

    return words
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  Future<void> _editProfile() async {
    final formKey = GlobalKey<FormState>();

    String editedName = _name;
    String editedMajor = _major;
    int editedYear = _graduationYear;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit profile'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Full name',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: 2),

                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editedName = value!.trim();
                    },
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Major',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: 2),

                  TextFormField(
                    initialValue: _major,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your major.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editedMajor = value!.trim();
                    },
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Graduation Year',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: 2),

                  TextFormField(
                    initialValue: _graduationYear.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      final year = int.tryParse(value?.trim() ?? '');

                      if (year == null || year < 2000 || year > 2100) {
                        return 'Enter a year between 2000 and 2100.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      editedYear = int.parse(value!.trim());
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.pop(dialogContext, true);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    setState(() {
      _name = editedName;
      _major = editedMajor;
      _graduationYear = editedYear;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myExperiences = mockExperiences
        .where((experience) => experience.authorId == mockCurrentUserId)
        .toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: AppTextStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      _initials,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: AppTextStyles.heading,
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '$_major • Class of $_graduationYear',
                          style: AppTextStyles.caption,
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          'student@example.com',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _editProfile,
                  child: const Text('Edit profile'),
                ),
              ),

              const Divider(color: AppColors.border),

              ListTile(
                leading: const Icon(
                  Icons.bookmark_outline,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Saved experiences',
                  style: AppTextStyles.body,
                ),
                trailing: ListenableBuilder(
                  listenable: savedExperiences,
                  builder: (context, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${savedExperiences.items.length}',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Icon(Icons.chevron_right),
                      ],
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.saved);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.business_outlined,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Following',
                  style: AppTextStyles.body,
                ),
                trailing: ListenableBuilder(
                  listenable: followedOrganizations,
                  builder: (context, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${followedOrganizations.items.length}',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Icon(Icons.chevron_right),
                      ],
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.following);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primary,
                ),
                title: const Text(
                  'Internship verification',
                  style: AppTextStyles.body,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.verification);
                },
              ),

              if (mockIsAdmin)
                ListTile(
                  leading: const Icon(
                    Icons.admin_panel_settings_outlined,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'Admin verification',
                    style: AppTextStyles.body,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.admin,
                    );
                  },
                ),

              const SizedBox(height: AppSpacing.lg),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),

              const Text(
                'My experiences',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: AppSpacing.sm),

              if (myExperiences.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No experiences shared yet',
                          style: AppTextStyles.body,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'Share your internship experience to help other students.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...myExperiences.map((experience) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ExperienceCard(
                      key: ValueKey(experience.id),
                      experience: experience,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.experienceDetail,
                          arguments: experience,
                        );
                      },
                    ),
                  );
                }),

              const SizedBox(height: AppSpacing.sm),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.addExperience,
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Share an experience'),
              ),

              const SizedBox(height: AppSpacing.lg),
              const Divider(color: AppColors.border),

              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.error,
                ),
                title: const Text(
                  'Log out',
                  style: AppTextStyles.body,
                ),
                onTap: () async {
                  final bool? confirmed = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Log out?'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, true);
                            },
                            child: const Text('Log out'),
                          ),
                        ],
                      );
                    },
                  );

                  if (!context.mounted) return;

                  if (confirmed == true) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                          (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}