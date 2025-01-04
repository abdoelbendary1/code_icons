import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/reciets_collections/all_reciets.dart';
import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
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
  ControllerManager controllerManager = ControllerManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerManager.clearControllers(
        controllers: controllerManager.recietCollectionController);
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
  void didUpdateWidget(covariant RecietScreenBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
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
              controller: controllerManager.paperNum,
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.number,
              onTap: () {
                controllerManager.paperNum.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: controllerManager.paperNum.value.text.length);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال رقم اول ورقه";
                }
                if (int.tryParse(value)! <
                    recietCollctionCubit.lastRecietCollection.paperNum! +
                        recietCollctionCubit
                            .lastRecietCollection.totalPapers!) {
                  return "يجب ادخال اول ورقه اكبر من ${recietCollctionCubit.lastRecietCollection.paperNum! + recietCollctionCubit.lastRecietCollection.totalPapers! - 1}";
                }
                return null;
              },
            ),
            BuildTextField(
              label: "عدد الورقات ",
              hint: "ادخل العدد",
              controller: controllerManager.totalPapers,
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.number,
              onTap: () {
                controllerManager.totalPapers.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        controllerManager.totalPapers.value.text.length);
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
                  await recietCollctionCubit.addReceipt(
                    context,
                    newReceipt: RecietCollectionDataModel(
                      paperNum: int.parse(controllerManager.paperNum.text),
                      totalPapers:
                          int.parse(controllerManager.totalPapers.text),
                    ),
                    userId: await recietCollctionCubit.getUserId(),
                  );
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
