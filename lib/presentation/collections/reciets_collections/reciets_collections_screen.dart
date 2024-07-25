import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';

class RecietsCollectionsScreen extends StatelessWidget {
  RecietsCollectionsScreen({super.key});
  static String routeName = "RecietsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: CustomSliverAppBar(
          body: Center(
            child: Text("Reciets"),
          ),
          title: "دفاتر الايصالات"),
    );
  }
}
