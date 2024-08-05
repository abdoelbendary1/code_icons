import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/cubit/unlimited_collection_cubit.dart';
import 'package:code_icons/presentation/collections/collections_screen.dart';
import 'package:code_icons/presentation/collections/reciets_collections/all_reciets.dart';
import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecietScreenBody extends StatefulWidget {
  const RecietScreenBody({super.key});

  @override
  State<RecietScreenBody> createState() => _RecietScreenBodyState();
}

class _RecietScreenBodyState extends State<RecietScreenBody> {
  RecietCollctionCubit recietCollctionCubit = RecietCollctionCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* ControllerManager().recietCollectionController.last.clear(); */
    ControllerManager().clearControllers(
        controllers: ControllerManager().recietCollectionController);
    recietCollctionCubit.getLastReciet();
  }

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant RecietScreenBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  /* @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ControllerManager().totalPapers.dispose();
    ControllerManager().paperNum.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Form(
      key: recietCollctionCubit.formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            BuildTextField(
              label: "رقم اول ورقه",
              hint: "ادخل الرقم",
              controller: ControllerManager().getControllerByName('paperNum'),
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.number,
              onTap: () {
                ControllerManager().getControllerByName('paperNum').selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .getControllerByName('paperNum')
                            .value
                            .text
                            .length);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال رقم اول ورقه";
                }
                return null;
              },
            ),
            BuildTextField(
              label: "عدد الورقات ",
              hint: "ادخل العدد",
              controller:
                  ControllerManager().getControllerByName('totalPapers'),
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.number,
              onTap: () {
                ControllerManager()
                        .getControllerByName('totalPapers')
                        .selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: ControllerManager()
                            .getControllerByName('totalPapers')
                            .value
                            .text
                            .length);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال عدد الورقات";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            buildSaveButton(context),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Row buildSaveButton(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        BlocListener<RecietCollctionCubit, RecietCollctionState>(
          bloc: recietCollctionCubit,
          listener: (context, state) {
            if (state is AddRecietCollctionSuccess) {
              SnackBarUtils.showSnackBar(
                context: context,
                label: "تمت الإضافه بنجاح",
                backgroundColor: AppColors.greenColor,
              );
              Navigator.pushReplacementNamed(
                  context, AllRecietsScreen.routeName);
            } else if (state is AddRecietCollctionError) {
              if (state.errorMsg.contains("400")) {
                SnackBarUtils.showSnackBar(
                  context: context,
                  label: "برجاء ادخال البيانات صحيحه",
                  backgroundColor: AppColors.redColor,
                );
              } else if (state.errorMsg.contains("500")) {
                SnackBarUtils.showSnackBar(
                  context: context,
                  label: "حدث خطأ ما",
                  backgroundColor: AppColors.redColor,
                );
                print(state.errorMsg);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                recietCollctionCubit.addReciet(context);
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }
}
