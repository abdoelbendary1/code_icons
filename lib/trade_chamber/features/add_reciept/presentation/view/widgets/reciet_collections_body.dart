import 'package:code_icons/core/widgets/custom_snack_bar.dart';
import 'package:code_icons/trade_chamber/core/widgets/build_textfield.dart';
import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/view/all_reciets.dart';
import 'package:code_icons/trade_chamber/features/add_reciept/presentation/controller/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RecietScreenBody extends StatefulWidget {
  const RecietScreenBody({super.key});

  @override
  State<RecietScreenBody> createState() => _RecietScreenBodyState();
}

class _RecietScreenBodyState extends State<RecietScreenBody> {
  RecietCollctionCubit recietCollctionCubit = RecietCollctionCubit();

  @override
  void initState() {
    super.initState();

    ControllerManager().clearControllers(
        controllers: ControllerManager().recietCollectionController);
    recietCollctionCubit.getLastReciet();
    RecietCollctionCubit.initHive();
    Future.delayed(Durations.medium1);
  }

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }

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
              Navigator.pushReplacementNamed(
                  context, AllRecietsScreen.routeName);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                title: "تمت الإضافه بنجاح",
                titleColor: AppColors.lightBlueColor,
              );
            } else if (state is AddRecietCollctionError) {
              if (state.errorMsg.contains("400")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: "برجاء ادخال البيانات صحيحه",
                  titleColor: AppColors.redColor,
                );
              } else if (state.errorMsg.contains("500")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: "حدث خطأ ما",
                  titleColor: AppColors.redColor,
                );

                print(state.errorMsg);
              } else {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                );
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
                if (recietCollctionCubit.formKey.currentState!.validate()) {
                  recietCollctionCubit.receipts =
                      await recietCollctionCubit.getReciets();
                  if (recietCollctionCubit.receipts.isNotEmpty) {
                    showCustomSnackBar(
                      context: context,
                      message: "هل انت متأكد من حذف الدفتر الحالي؟",
                      type: SnackBarType.confirm,
                      confirmText: "نعم",
                      cancelText: "رجوع",
                      onConfirm: () async {
                        await recietCollctionCubit.addReciet();
                      },
                    );
                  } else {
                    await recietCollctionCubit.addReciet();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "برجاء ادخال جميع البيانات",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    backgroundColor: AppColors.redColor,
                    duration: const Duration(seconds: 3),
                  ));
                }
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
