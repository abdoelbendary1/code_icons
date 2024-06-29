import 'package:flutter/material.dart';

class EcommerceSetting extends StatelessWidget {
  const EcommerceSetting({super.key});

  static const routeName = "E-commerce Setting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Setting'),
      ),
      body: const Center(
        child: Text('This is E-commerce Setting'),
      ),
    );
  }
}
