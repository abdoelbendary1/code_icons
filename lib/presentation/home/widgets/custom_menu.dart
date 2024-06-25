import 'package:code_icons/presentation/home/widgets/custom_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: SizedBox(
                height: MediaQuery.of(context).size.height.h * 0.9,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CustomDrawerItem(
                    title: "Item ${index + 1}",
                    subtitle: "Subtitle",
                    subtitleCount: 3,
                  ),
                  itemCount: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
