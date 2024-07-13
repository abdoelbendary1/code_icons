import 'package:flutter/material.dart';

class SystemSettings extends StatelessWidget {
  const SystemSettings({super.key});

  static const routeName = "System Settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Settings'),
      ),
      body: const Center(
        child: Text('This is System Settings'),
      ),
    );
  }
}
