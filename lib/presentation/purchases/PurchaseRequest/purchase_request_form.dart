import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/reciets_collections/all_reciets.dart';
import 'package:code_icons/presentation/collections/reciets_collections/cubit/reciet_collction_cubit.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/select_store.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseRequestForm extends StatefulWidget {
  const PurchaseRequestForm({super.key});

  @override
  State<PurchaseRequestForm> createState() => _PurchaseRequestFormState();
}

class _PurchaseRequestFormState extends State<PurchaseRequestForm> {
  PurchasesCubit purchasesCubit = PurchasesCubit();
  bool isVisable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* ControllerManager().recietCollectionController.last.clear(); */
    /* ControllerManager().clearControllers(
        controllers: ControllerManager().recietCollectionController);
    PurchasesCubit.petLastReciet(); */
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: purchasesCubit.formKey,
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
            Accordion(
              paddingBetweenClosedSections: 20,
              disableScrolling: true,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              contentBorderWidth: 0,
              contentBackgroundColor: Colors.transparent,
              headerBackgroundColorOpened: AppColors.greenColor,
              maxOpenSections: 1,
              headerBackgroundColor: AppColors.lightBlueColor,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                buildRequestInfoSection(context),
                buildItemInfoSection(context),
              ],
            ),
            SizedBox(height: 10.h),
            buildSaveButton(
              mainAxisAlignment: MainAxisAlignment.end,
              title: AppLocalizations.of(context)!.save,
              context: context,
              onPressed: () async {
                purchasesCubit.addPurchaseRequest();
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Row buildSaveButton({
    required BuildContext context,
    required void Function()? onPressed,
    required String title,
    required MainAxisAlignment mainAxisAlignment,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        BlocListener<PurchasesCubit, PurchasesState>(
          bloc: purchasesCubit,
          listener: (context, state) {
            if (state is AddPurchasesRequestSuccess) {
              /* SnackBarUtils.hideCurrentSnackBar(context: context); */
              SnackBarUtils.showSnackBar(
                context: context,
                label: "تمت الإضافه بنجاح",
                backgroundColor: AppColors.greenColor,
              );
              /*  Navigator.pushReplacementNamed(
                        context, AllRecietsScreen.routeName); */
            } else if (state is AddPurchasesRequestError) {
              if (state.errorMsg.contains("400")) {
                SnackBarUtils.hideCurrentSnackBar(context: context);
                SnackBarUtils.showSnackBar(
                  context: context,
                  label: "برجاء ادخال البيانات صحيحه",
                  backgroundColor: AppColors.redColor,
                );
              } else if (state.errorMsg.contains("500")) {
                SnackBarUtils.hideCurrentSnackBar(context: context);
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
              onPressed: onPressed,
              child: Text(title),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }

  AccordionSection buildItemInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "2",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('بيانات المنتج',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<PurchasesCubit, PurchasesState>(
        bloc: purchasesCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AddPurchasesItemloading) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: BlocConsumer<PurchasesCubit, PurchasesState>(
                          bloc: purchasesCubit
                            ..tradeList.clear()
                            ..fetchTradeList(),
                          listener: (context, state) {},
                          builder: (context, state) {
                            return SelectableDropDownlist(
                              title: "الكود",
                              hintText: "اختيار الكود",
                              itemList: purchasesCubit.tradeList,
                              onChanged: (value) {
                                print(value);
                                context
                                    .read<PurchasesCubit>()
                                    .updateTradeRegistryType(value!);
                              },
                            );
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: BlocConsumer<PurchasesCubit, PurchasesState>(
                          bloc: purchasesCubit
                            ..tradeList.clear()
                            ..fetchTradeList(),
                          listener: (context, state) {},
                          builder: (context, state) {
                            return SelectableDropDownlist(
                              title: "الاسم",
                              hintText: "اختيار الاسم",
                              itemList: purchasesCubit.tradeList,
                              onChanged: (value) {
                                print(value);
                                context
                                    .read<PurchasesCubit>()
                                    .updateTradeRegistryType(value!);
                              },
                            );
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: BlocConsumer<PurchasesCubit, PurchasesState>(
                          bloc: purchasesCubit
                            ..tradeList.clear()
                            ..fetchTradeList(),
                          listener: (context, state) {},
                          builder: (context, state) {
                            return SelectableDropDownlist(
                              title: "وحدة القياس",
                              hintText: "اختيار وحدة القياس",
                              itemList: purchasesCubit.tradeList,
                              onChanged: (value) {
                                print(value);
                                context
                                    .read<PurchasesCubit>()
                                    .updateTradeRegistryType(value!);
                              },
                            );
                          },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildTextField(
                        label: "الكميه",
                        hint: "الكميه",
                        controller: ControllerManager()
                            .getControllerByName('divisionBL'),
                        icon: Icons.diversity_3_sharp,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال النشاط";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('divisionBL')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName('divisionBL')
                                      .value
                                      .text
                                      .length);
                        }),
                    BuildTextField(
                        label: "الوصف",
                        hint: "الوصف",
                        controller:
                            ControllerManager().getControllerByName('ownerBL'),
                        icon: Icons.phone_iphone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال اسم المالك";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('ownerBL')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName('ownerBL')
                                      .value
                                      .text
                                      .length);
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildSaveButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      title: " اضافه المنتج",
                      context: context,
                      onPressed: () async {
                        purchasesCubit.saveItem();
                      },
                    ),
                  ],
                ),
              ],
            );
          } else if (state is PurchasesInitial) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                buildSaveButton(
                    mainAxisAlignment: MainAxisAlignment.center,
                    title: "إضافه منتج جديد",
                    context: context,
                    onPressed: () async {
                      purchasesCubit.addItem();
                    }),
                SizedBox(
                  height: 60.h,
                ),
              ],
            );
          } else if (state is AddPurchasesItemError) {
            return LoadingStateAnimation();
          }
          return Container();
        },
      ),
    );
  }

  AccordionSection buildRequestInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "1",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('بيانات الطلب',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              BuildTextField(
                  label: "كود",
                  hint: "كود",
                  keyboardType: TextInputType.number,
                  controller:
                      ControllerManager().getControllerByName('divisionBL'),
                  icon: Icons.diversity_3_sharp,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "لا يمكن ترك الجقل فارغاً";
                    }
                    return null;
                  },
                  onTap: () {
                    ControllerManager()
                            .getControllerByName('divisionBL')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName('divisionBL')
                                .value
                                .text
                                .length);
                  }),
              BuildTextField(
                label: "التاريخ",
                hint: "التاريخ ",
                controller:
                    ControllerManager().getControllerByName('birthDayBL'),
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          ControllerManager().getControllerByName('birthDayBL'),
                      dateStorageMap: purchasesCubit.dateStorageMap,
                      key: "birthDayBL");
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ الميلاد";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit
                      ..tradeList.clear()
                      ..fetchTradeList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        title: "المركز",
                        hintText: "اختيار المركز",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          print(value);
                          context
                              .read<PurchasesCubit>()
                              .updateTradeRegistryType(value!);
                        },
                      );
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit
                      ..tradeList.clear()
                      ..fetchTradeList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        title: "الحاله",
                        hintText: "اختيار الحاله",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          print(value);
                          context
                              .read<PurchasesCubit>()
                              .updateTradeRegistryType(value!);
                        },
                      );
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit
                      ..tradeList.clear()
                      ..fetchTradeList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        title: "cost center",
                        hintText: "اختيار الاسم",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          print(value);
                          context
                              .read<PurchasesCubit>()
                              .updateTradeRegistryType(value!);
                        },
                      );
                    },
                  )),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              BuildTextField(
                label: "تاريخ الرد",
                hint: "تاريخ الرد",
                controller:
                    ControllerManager().getControllerByName('birthDayBL'),
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          ControllerManager().getControllerByName('birthDayBL'),
                      dateStorageMap: purchasesCubit.dateStorageMap,
                      key: "birthDayBL");
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ الرد";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              BuildTextField(
                  label: "ملاحظات",
                  hint: "ملاحظات",
                  minLines: 1,
                  maxLines: 5,
                  controller:
                      ControllerManager().getControllerByName('addressBL'),
                  icon: Icons.phone_iphone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال ملاحظات";
                    }
                    return null;
                  },
                  onTap: () {
                    ControllerManager()
                            .getControllerByName('addressBL')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName('addressBL')
                                .value
                                .text
                                .length);
                  }),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
