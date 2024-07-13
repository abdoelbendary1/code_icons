import 'package:flutter/material.dart';

class CustomerDataScreen extends StatelessWidget {
  const CustomerDataScreen({super.key});

  static const routeName = "CustomerDataScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomerDataScreen'),
      ),
      body: const Center(
        child: Text('CustomerDataScreen'),
      ),
    );
  }
}
