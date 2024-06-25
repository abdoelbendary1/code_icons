import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          "Data",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
  }
}