import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciets_collections_screen.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AllRecietsScreen extends StatefulWidget {
  AllRecietsScreen({super.key});
  static const String routeName = "AllRecietsScreen";

  @override
  State<AllRecietsScreen> createState() => _AllRecietsScreenState();
}

class _AllRecietsScreenState extends State<AllRecietsScreen> {
  final RecietCollctionCubit recietCollctionCubit = RecietCollctionCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RecietCollctionCubit.initHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocBuilder<RecietCollctionCubit, RecietCollctionState>(
        bloc: recietCollctionCubit,
        builder: (context, state) {
          return SpeedDial(
            gradientBoxShape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.blueColor, AppColors.lightBlueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            switchLabelPosition: true,
            spaceBetweenChildren: 10,
            icon: Icons.menu,
            activeIcon: Icons.close,
            backgroundColor: AppColors.blueColor,
            foregroundColor: Colors.white,
            activeBackgroundColor: AppColors.blueColor,
            activeForegroundColor: Colors.white,
            buttonSize: const Size(56.0,
                56.0), // it's the SpeedDial size which defaults to 56 itself
            childrenButtonSize: const Size(
                56.0, 56.0), // it's the same as buttonSize by default
            direction:
                SpeedDialDirection.up, // default is SpeedDialDirection.up
            renderOverlay: true, // default is true
            overlayOpacity: 0.5, // default is 0.5
            overlayColor: Colors.black, // default is Colors.black
            tooltip: 'Open Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            elevation: 8.0, // default is 6.0
            shape: const CircleBorder(), // default is CircleBorder
            children: [
              SpeedDialChild(
                /*  child: const Icon(Icons.add, color: Colors.white), */
                backgroundColor: AppColors.blueColor,
                labelWidget: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    gradient: const LinearGradient(
                      colors: [AppColors.blueColor, AppColors.lightBlueColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' إضافة دفتر',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RecietsCollectionsScreen.routeName);
                },
              ),
              recietCollctionCubit.receipts.isNotEmpty
                  ? SpeedDialChild(
                      /*  child: const Icon(Icons.delete, color: Colors.white), */
                      backgroundColor: AppColors.redColor,
                      labelWidget: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: AppColors.redColor,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.redColor,
                              AppColors.lightRedColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ' حذف جميع الدفاتر',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        recietCollctionCubit.removeAllReciets();
                      },
                    )
                  : SpeedDialChild()
            ],
          );
        },
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blueColor, AppColors.lightBlueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            toolbarHeight: 120.h,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "دفاتر الإيصالات",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<RecietCollctionCubit, RecietCollctionState>(
        listener: (context, state) {
          if (state is RemoveRecietError) {
            QuickAlert.show(
              animType: QuickAlertAnimType.slideInUp,
              context: context,
              type: QuickAlertType.error,
              showConfirmBtn: false,
              title: state.errorMsg,
              titleColor: AppColors.redColor,
            );
          } else if (state is RemoveRecietSuccess) {
            QuickAlert.show(
              animType: QuickAlertAnimType.slideInUp,
              context: context,
              type: QuickAlertType.success,
              showConfirmBtn: false,
              title: "تم حذف الدفتر بنجاح",
              titleColor: AppColors.lightBlueColor,
            );
          }
        },
        bloc: recietCollctionCubit..getReciets(),
        builder: (context, state) {
          if (state is GetRecietCollctionSuccess) {
            recietCollctionCubit.receipts = state.reciets;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "سجل الدفاتر",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor.withOpacity(0.8),
                              fontSize: 25,
                            ),
                          ),
                          const Text(
                            "لكل محصل الدفاتر الخاصه به",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColors.greyColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var reciept = state.reciets[index];
                        return ExpansionTile(
                          iconColor: AppColors.lightBlueColor,
                          collapsedIconColor: AppColors.lightBlueColor,
                          maintainState: true,
                          collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),

                          /* collapsedBackgroundColor: AppColors.blueColor, */
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  "دفتر : ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                Text(
                                  "${state.reciets[index].id}",
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                const Spacer(),
                                reciept.valid!
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.greenColor
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "متاح",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "منتهي",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          children: [
                            SwipeActionCell(
                              leadingActions: [
                                SwipeAction(
                                  nestedAction: SwipeNestedAction(
                                    content: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppColors.blueColor,
                                            AppColors.lightBlueColor
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      width: 80.sp,
                                      height: 50.sp,
                                      child: const OverflowBox(
                                        maxWidth: double.infinity,
                                        child: Center(
                                          child: Text(
                                            'حذف',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  content:
                                      _getIconButton(Colors.red, Icons.delete),
                                  onTap: (handler) async {
                                    recietCollctionCubit
                                        .removeReciet(reciept.id!);
                                  },
                                ),
                              ],
                              key: ValueKey(index),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 8.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: 10.w,
                                          runSpacing: 20.h,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 10.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightBlueColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.filter_1_outlined,
                                                      size: 20.sp),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    "الورقه الاولى: ${state.reciets[index].paperNum}",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 10.h),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.file_copy_outlined,
                                                      size: 20.sp),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    "عدد الورقات: ${state.reciets[index].totalPapers}",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: state.reciets.length,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetRecietCollctionError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.errorMsg,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state is GetRecietCollctionLoading) {
            return const Center(
              child: LoadingStateAnimation(),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _getIconButton(color, icon) {
    return Container(
      width: 80.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [AppColors.redColor, AppColors.lightRedColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        /// set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
