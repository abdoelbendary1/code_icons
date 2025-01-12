import 'package:code_icons/trade_chamber/features/add_reciept/presentation/controller/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/purchase_request.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_state.dart';
import 'package:code_icons/presentation/utils/build_app_bar.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class AllPurchasesScreen extends StatefulWidget {
  AllPurchasesScreen({super.key});
  static const String routeName = "AllPurchasesScreen";

  @override
  State<AllPurchasesScreen> createState() => _AllPurchasesScreenState();
}

class _AllPurchasesScreenState extends State<AllPurchasesScreen> {
  /* final RecietCollctionCubit recietCollctionCubit = RecietCollctionCubit(); */
  PurchasesCubit purchasesCubit = PurchasesCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purchasesCubit.fetchAllPurchaseRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<PurchasesCubit, PurchasesState>(
        bloc: purchasesCubit,
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
                          ' طلب شراء',
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
                      context, PurchaseRequest.routeName);
                },
              ),
              /*  recietCollctionCubit.receipts.isNotEmpty
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
                  : SpeedDialChild() */
            ],
          );
        },
      ),
      appBar: buildAppBar(context: context, title: "المشتريات"),
      body: BlocBuilder<PurchasesCubit, PurchasesState>(
        bloc: purchasesCubit,
        builder: (context, state) {
          if (state is GetPurchasesListSuccess) {
            if (state.purchases.isEmpty) {
              return Center(
                child: Text(
                  "لا يوجد شراءات حاليه",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: state.purchases.length,
              itemBuilder: (context, index) {
                final request = state.purchases[index];
                return SwipeActionCell(
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
                            color: Colors.red,
                          ),
                          width: 80.sp,
                          height: 50.sp,
                          child: const OverflowBox(
                            maxWidth: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('حذف',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      color: Colors.transparent,
                      content: purchasesCubit.getIconButton(
                          Colors.red, Icons.delete),
                      onTap: (handler) async {
                        // Implement delete functionality
                      },
                    ),
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
                            "تاريخ الطلب: ${purchasesCubit.convertToDateString(request.date ?? "")}",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "id: ${request.id}",
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
                                    horizontal: 16.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "تم التأكيد",
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
            );
          } else if (state is GetPurchasesListError) {
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
            return Center(
              child: LoadingStateAnimation(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
