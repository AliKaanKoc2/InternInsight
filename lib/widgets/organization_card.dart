import 'package:flutter/material.dart';

import '../core/routes/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../data/models/organization.dart';

class OrganizationCard extends StatelessWidget {
  final Organization organization;

  const OrganizationCard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(organization.logoUrl, width: 48, height: 48),
        title: Text(organization.name, style: AppTextStyles.heading),
        subtitle: Text(
          '${organization.industry} · ${organization.location}',
          style: AppTextStyles.caption,
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: AppColors.warning),
                Text('${organization.rating}', style: AppTextStyles.label),
              ],
            ),
            Text(
              '${organization.experienceCount} experiences',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.organizationDetail,
            arguments: organization,
          );
        },
      ),
    );
  }
}