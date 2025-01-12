import 'package:code_icons/core/theme/sizes_manager.dart';
import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/presentation/home/widgets/custom_card.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/trade_chamber/view/widgets/build_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  static const routeName = "CollectionsScreen";

  @override
  Widget build(BuildContext context) {
    var menuItems =
        ModalRoute.of(context)!.settings.arguments as List<MenuItem>;
    return Scaffold(
      appBar: buildAppBar(context: context, title: "التحصيلات"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sizes.size24.verticalSpace,
          const BuildSectionTitle(
            title: "التحصيلات المالية",
            subtitle: "ماذا تريد أن تفعل الأن؟",
          ),
          Sizes.size20.verticalSpace,
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                String title = menuItems[index].title;

                String routeName = menuItems[index].route;

                return CustomCard(
                  title: title,
                  routeName: routeName,
                );
              },
              itemCount: menuItems.length,
            ),
          )
        ],
      ),
    );
  }
}
