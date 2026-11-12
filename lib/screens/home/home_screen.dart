import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _filters = const [
    'Latest',
    'Top rated',
    'Verified',
  ];

  String _selectedFilter = 'Latest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'InternInsight',
          style: AppTextStyles.title,
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: (){
              Navigator.pushNamed(context, AppRoutes.search);
            },
          ),
          IconButton(
            tooltip: 'Saved experiences',
            icon: const Icon(Icons.bookmark_outline),
            onPressed: (){
              Navigator.pushNamed(context, AppRoutes.saved);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _filters.map((filter){
                  return ChoiceChip(
                    label: Text(filter),
                    selected : _selectedFilter == filter,
                    onSelected: (selected) {
                      if (selected) {
                        setState((){
                          _selectedFilter = filter;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              const Expanded(
                child: Center(
                  child: Text(
                    'Experience cards will appear here.',
                    style: AppTextStyles.caption,
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