import 'package:flutter/material.dart';

class OrganizationListScreen extends StatelessWidget {
  const OrganizationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organizations')),
      body: const Center(child: const Text('05 Organizations')),
    );
  }
}
