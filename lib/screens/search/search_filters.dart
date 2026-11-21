import 'package:flutter/material.dart';

class SearchFilters extends StatelessWidget {
  const SearchFilters({
    super.key,
    required this.verifiedOnly,
    required this.onVerifiedOnlyChanged,
  });

  final bool verifiedOnly;
  final ValueChanged<bool> onVerifiedOnlyChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text('Only verified experiences')),
        Switch(value: verifiedOnly, onChanged: onVerifiedOnlyChanged),
      ],
    );
  }
}
