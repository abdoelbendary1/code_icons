import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/collections/reciets_collections/reciets_collections_screen.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

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
                          ' إضافة إيصال',
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
                                ' حذف جميع الإيصالات',
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
              "سجل الايصالات",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<RecietCollctionCubit, RecietCollctionState>(
        bloc: recietCollctionCubit..getReciets(),
        builder: (context, state) {
          if (state is GetRecietCollctionSuccess) {
            if (state.reciets.isEmpty) {
              return Center(
                child: Text(
                  "لا يوجد ايصالات حاليا",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            recietCollctionCubit.receipts = state.reciets;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemBuilder: (context, index) {
                return SwipeActionCell(
                  leadingActions: [
                    SwipeAction(
                        nestedAction: SwipeNestedAction(
                          /// customize your nested action content
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
                              color: Colors.red,
                            ),
                            width: 80.sp,
                            height: 50.sp,
                            child: const OverflowBox(
                              maxWidth: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /* Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ), */
                                  Text('حذف',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// you should set the default  bg color to transparent
                        color: Colors.transparent,

                        /// set content instead of title of icon
                        content: _getIconButton(Colors.red, Icons.delete),
                        onTap: (handler) async {
                          /*   list.removeAt(index);
                          setState(() {},); */
                          recietCollctionCubit.removeReciet(index + 1);
                        }),
                  ],
                  key: ValueKey(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Card(
                      color: AppColors.blueColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.blueColor,
                              AppColors.lightBlueColor
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.w),
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.lightBlueColor,
                            child: Icon(
                              Icons.receipt,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "اول ورقه :  ${state.reciets[index].paperNum}",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "عدد الورقات : ${state.reciets[index].totalPapers}",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "تم التأكيد", // Example status
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.reciets.length,
            );
          } else if (state is GetRecietCollctionError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.errorMsg,
                  style: TextStyle(fontSize: 18.sp, color: AppColors.redColor),
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
