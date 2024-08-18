import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:code_icons/domain/entities/purchase_item/purchase_item_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/purchases/cubit/purchases_cubit.dart';
import 'package:code_icons/presentation/purchases/getAllPurchases/view/all_purchases.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/GlobalVariables.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class PurchaseInvoiceForm extends StatefulWidget {
  const PurchaseInvoiceForm({super.key});

  @override
  State<PurchaseInvoiceForm> createState() => _PurchaseInvoiceFormState();
}

class _PurchaseInvoiceFormState extends State<PurchaseInvoiceForm> {
  PurchasesCubit purchasesCubit = PurchasesCubit();
  StatefulWidget? myInheritedWidget;

  @override
  void initState() {
    super.initState();
    ControllerManager().clearControllers(
        controllers: ControllerManager().purchaseRequestControllers);
    /* ControllerManager().clearControllers(
        controllers: ControllerManager().recietCollectionController);
    PurchasesCubit.petLastReciet(); */
    purchasesCubit.selectedItem = PurchaseItemEntity();
    purchasesCubit.fetchProductInfoDatalists();

    purchasesCubit.getItemsData();
    purchasesCubit.fetchUom();
    Future.delayed(const Duration(seconds: 1));
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
                buildInvoiceInfoSection(context),
                buildItemInfoSection(context),
                buildSelectedItemsList(context),
              ],
            ),
            SizedBox(height: 10.h),
            buildSaveButton(
              mainAxisAlignment: MainAxisAlignment.end,
              title: AppLocalizations.of(context)!.save,
              context: context,
              onPressed: () async {
                purchasesCubit.addPurchaseRequest(context: context);
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
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
          if (state is AddPurchasesItemloading ||
              state is PurchasesItemSelected) {
            return buildProductInfoWhileSelecting(context);
          } else if (state is PurchasesInitial) {
            return buildAddFirstProduct(context);
          } else if (state is AddPurchasesItemSuccess) {
            return buildItemsListWithAddition(context);
          } else if (state is AddPurchasesItemError) {
            return const LoadingStateAnimation();
          }
          return Container();
        },
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
              SnackBarUtils.showSnackBar(
                context: GlobalVariable.navigatorState.currentContext!,
                label: "تمت الإضافه بنجاح",
                backgroundColor: AppColors.greenColor,
              );
              Navigator.pushReplacementNamed(
                  super.context, AllPurchasesScreen.routeName);
            } else if (state is AddPurchasesRequestError) {
              if (state.errorMsg.contains("400")) {
                SnackBarUtils.showSnackBar(
                  context: GlobalVariable.navigatorState.currentContext!,
                  label: "برجاء ادخال البيانات صحيحه",
                  backgroundColor: AppColors.redColor,
                );
              } else if (state.errorMsg.contains("500")) {
                SnackBarUtils.showSnackBar(
                  context: GlobalVariable.navigatorState.currentContext!,
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

  Column buildItemsListWithAddition(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        buildSaveButton(
            mainAxisAlignment: MainAxisAlignment.center,
            title: "إضافه منتج جديد",
            context: context,
            onPressed: () async {
              purchasesCubit.addItem();
            }),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget buildAddFirstProduct(BuildContext context) {
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
  }

  Column buildProductInfoWhileSelecting(BuildContext context) {
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
                  bloc: purchasesCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PurchasesItemSelected) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال الكود";
                          }
                          return null;
                        },
                        initialItem: state.selectedItem.itemCode1,
                        title: "الكود",
                        hintText: "اختيار الكود",
                        itemList: purchasesCubit.itemsCodesList,
                        onChanged: (value) {
                          purchasesCubit.selectItem(code: value);
                        },
                      );
                    }
                    return SelectableDropDownlist(
                      validator: (value) {
                        if (value == null) {
                          return "يجب ادخال الكود";
                        }
                        return null;
                      },
                      title: "الكود",
                      hintText: "اختيار الكود",
                      itemList: purchasesCubit.itemsCodesList,
                      onChanged: (value) {
                        purchasesCubit.selectItem(code: value);
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
                  bloc: purchasesCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PurchasesItemSelected) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال الاسم";
                          }
                          return null;
                        },
                        initialItem: state.selectedItem.itemNameAr,
                        title: "الاسم",
                        hintText: "اختيار الاسم",
                        itemList: purchasesCubit.itemsNamesList,
                        onChanged: (value) {
                          /* purchasesCubit.selectItem(
                              code: state.selectedItem.itemCode1!); */
                          /* state.selectedItem.itemNameAr = value; */
                          purchasesCubit.selectItem(name: value);
                        },
                      );
                    }

                    return SelectableDropDownlist(
                      validator: (value) {
                        if (value == null) {
                          return "يجب ادخال الاسم";
                        }
                        return null;
                      },
                      title: "الاسم",
                      hintText: "اختيار الاسم",
                      itemList: purchasesCubit.itemsNamesList,
                      onChanged: (value) {
                        purchasesCubit.selectItem(name: value);
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
                  bloc: purchasesCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PurchasesItemSelected) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null) {
                            return "يجب ادخال الوحده";
                          }
                          return null;
                        },
                        initialItem: state.selectedItem.itemUom?.first.uom,
                        title: "وحدة القياس",
                        hintText: "اختيار وحدة القياس",
                        itemList: purchasesCubit.uomNamesList,
                        onChanged: (value) {
                          purchasesCubit.selectUom(name: value);
                        },
                      );
                    }
                    return SelectableDropDownlist(
                      title: "وحدة القياس",
                      hintText: "اختيار وحدة القياس",
                      itemList: purchasesCubit.uomNamesList,
                      onChanged: (value) {
                        purchasesCubit.selectUom(name: value);
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
                label: "سعر شراء الوحدة",
                hint: "سعر شراء الوحدة",
                controller: ControllerManager()
                    .getControllerByName('purchaseItemDiscriptionController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال سعر";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('purchaseItemDiscriptionController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'purchaseItemDiscriptionController')
                              .value
                              .text
                              .length);
                }),
            BlocBuilder<PurchasesCubit, PurchasesState>(
              bloc: purchasesCubit,
              builder: (context, state) {
                /*      if (state is PurchasesItemSelected) */ {
                  return Row(
                    children: [
                      Expanded(
                        child: BuildTextField(
                            label: "الكمية",
                            hint: "الكمية",
                            controller: ControllerManager().getControllerByName(
                                'purchaseItemQuantitytemController'),
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الكمية";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .getControllerByName(
                                          'purchaseItemQuantitytemController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'purchaseItemQuantitytemController')
                                          .value
                                          .text
                                          .length);
                            }),
                      ),
                      Expanded(
                        child: BuildTextField(
                            label: "إجمالي الكمية",
                            hint: "إجمالي الكمية",
                            controller: ControllerManager().getControllerByName(
                                'purchaseItemQuantitytemController'),
                            icon: Icons.diversity_3_sharp,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يجب ادخال الكميه";
                              }
                              return null;
                            },
                            onTap: () {
                              ControllerManager()
                                      .getControllerByName(
                                          'purchaseItemQuantitytemController')
                                      .selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: ControllerManager()
                                          .getControllerByName(
                                              'purchaseItemQuantitytemController')
                                          .value
                                          .text
                                          .length);
                            }),
                      ),
                    ],
                  );
                }

                /*   return BuildTextField(
                    label: "الكميه",
                    hint: "الكميه",
                    controller: ControllerManager().getControllerByName(
                        'purchaseItemQuantitytemController'),
                    icon: Icons.diversity_3_sharp,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يجب ادخال الكميه";
                      }
                      return null;
                    },
                    onTap: () {
                      ControllerManager()
                              .getControllerByName(
                                  'purchaseItemQuantitytemController')
                              .selection =
                          TextSelection(
                              baseOffset: 0,
                              extentOffset: ControllerManager()
                                  .getControllerByName(
                                      'purchaseItemQuantitytemController')
                                  .value
                                  .text
                                  .length);
                    }); */
              },
            ),
            BuildTextField(
                label: "تاريخ الصلاحيه",
                hint: "تاريخ الصلاحيه",
                controller: ControllerManager()
                    .getControllerByName('purchaseItemDiscriptionController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ الصلاحيه";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('purchaseItemDiscriptionController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'purchaseItemDiscriptionController')
                              .value
                              .text
                              .length);
                }),
            BuildTextField(
                label: "رقم التشغيليه",
                hint: "رقم التشغيليه",
                controller: ControllerManager()
                    .getControllerByName('purchaseItemDiscriptionController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال الارتفاع";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('purchaseItemDiscriptionController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'purchaseItemDiscriptionController')
                              .value
                              .text
                              .length);
                }),
            Row(
              children: [
                Expanded(
                  child: BuildTextField(
                      label: "نسبة الخصم",
                      hint: "نسبة الخصم",
                      controller: ControllerManager().getControllerByName(
                          'purchaseItemDiscriptionController'),
                      icon: Icons.phone_iphone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال النسبه";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName(
                                    'purchaseItemDiscriptionController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'purchaseItemDiscriptionController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
                Expanded(
                  child: BuildTextField(
                      label: "قيمة الخصم",
                      hint: "قيمة الخصم",
                      controller: ControllerManager().getControllerByName(
                          'purchaseItemDiscriptionController'),
                      icon: Icons.phone_iphone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال قيمة";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName(
                                    'purchaseItemDiscriptionController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'purchaseItemDiscriptionController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextField(
                      label: "الطول",
                      hint: "الطول",
                      controller: ControllerManager().getControllerByName(
                          'purchaseItemDiscriptionController'),
                      icon: Icons.phone_iphone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال الطول";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName(
                                    'purchaseItemDiscriptionController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'purchaseItemDiscriptionController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
                Expanded(
                  child: BuildTextField(
                      label: "العرض",
                      hint: "العرض",
                      controller: ControllerManager().getControllerByName(
                          'purchaseItemDiscriptionController'),
                      icon: Icons.phone_iphone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يجب ادخال العرض";
                        }
                        return null;
                      },
                      onTap: () {
                        ControllerManager()
                                .getControllerByName(
                                    'purchaseItemDiscriptionController')
                                .selection =
                            TextSelection(
                                baseOffset: 0,
                                extentOffset: ControllerManager()
                                    .getControllerByName(
                                        'purchaseItemDiscriptionController')
                                    .value
                                    .text
                                    .length);
                      }),
                ),
              ],
            ),
            BuildTextField(
                label: "الارتفاع",
                hint: "الارتفاع",
                controller: ControllerManager()
                    .getControllerByName('purchaseItemDiscriptionController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال الارتفاع";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('purchaseItemDiscriptionController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'purchaseItemDiscriptionController')
                              .value
                              .text
                              .length);
                }),
            BuildTextField(
                label: "الوصف",
                hint: "الوصف",
                controller: ControllerManager()
                    .getControllerByName('purchaseItemDiscriptionController'),
                icon: Icons.phone_iphone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال الوصف";
                  }
                  return null;
                },
                onTap: () {
                  ControllerManager()
                          .getControllerByName('purchaseItemDiscriptionController')
                          .selection =
                      TextSelection(
                          baseOffset: 0,
                          extentOffset: ControllerManager()
                              .getControllerByName(
                                  'purchaseItemDiscriptionController')
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
                purchasesCubit.saveSelectedItem();
              },
            ),
          ],
        ),
      ],
    );
  }

  AccordionSection buildInvoiceInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "1",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('بيانات الفاتورة',
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
              Row(
                children: [
                  Expanded(
                    child: BuildTextField(
                        label: "كود",
                        hint: "كود",
                        keyboardType: TextInputType.number,
                        controller: ControllerManager()
                            .getControllerByName('purchaseCodeController'),
                        icon: Icons.diversity_3_sharp,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "لا يمكن ترك الحقل فارغاً";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('purchaseCodeController')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName(
                                          'purchaseCodeController')
                                      .value
                                      .text
                                      .length);
                        }),
                  ),
                  Expanded(
                    child: BuildTextField(
                        label: "كود المصدر",
                        hint: " كود",
                        keyboardType: TextInputType.number,
                        controller: ControllerManager()
                            .getControllerByName('purchaseCodeController'),
                        icon: Icons.diversity_3_sharp,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "لا يمكن ترك الحقل فارغاً";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('purchaseCodeController')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName(
                                          'purchaseCodeController')
                                      .value
                                      .text
                                      .length);
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الفرع";
                          }
                          return null;
                        },
                        title: "الفرع",
                        hintText: "اختيار الفرع",
                        itemList: purchasesCubit.storeNamesList,
                        onChanged: (value) {
                          purchasesCubit.selectStore(name: value);
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
                      ..fetchStatusList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال المورد";
                          }
                          return null;
                        },
                        title: "الموردين",
                        hintText: "اختيار المورد",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          purchasesCubit.selectedStatus = value;
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
                      ..fetchStatusList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال مركز التكلفة";
                          }
                          return null;
                        },
                        title: "مركز التكلفة",
                        hintText: "اختيار مركز",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          purchasesCubit.selectedStatus = value;
                        },
                      );
                    },
                  )),
                ],
              ),
              BuildTextField(
                label: "التاريخ",
                hint: "التاريخ ",
                controller: ControllerManager()
                    .getControllerByName('purchaseDateController'),
                readOnly: true,
                icon: Icons.app_registration,
                onTap: () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller: ControllerManager()
                          .getControllerByName('purchaseDateController'),
                      dateStorageMap: purchasesCubit.dateStorageMap,
                      key: "purchaseDateController");
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يجب ادخال تاريخ ";
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
                      ..fetchStatusList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاعتماد";
                          }
                          return null;
                        },
                        title: "الاعتماد المستندي",
                        hintText: "اختيار",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          purchasesCubit.selectedStatus = value;
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
                    bloc: purchasesCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال العمله";
                          }
                          return null;
                        },
                        title: "العمله",
                        hintText: "اختيار",
                        itemList: purchasesCubit.storeNamesList,
                        onChanged: (value) {
                          purchasesCubit.selectStore(name: value);
                        },
                      );
                    },
                  )),
                  Expanded(
                    child: BuildTextField(
                        label: "المعامل",
                        hint: "المعامل",
                        keyboardType: TextInputType.number,
                        controller: ControllerManager()
                            .getControllerByName('purchaseCodeController'),
                        icon: Icons.diversity_3_sharp,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "لا يمكن ترك الحقل فارغاً";
                          }
                          return null;
                        },
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('purchaseCodeController')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName(
                                          'purchaseCodeController')
                                      .value
                                      .text
                                      .length);
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<PurchasesCubit, PurchasesState>(
                    bloc: purchasesCubit
                      ..tradeList.clear()
                      ..fetchStatusList(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال طبيعه الدفع";
                          }
                          return null;
                        },
                        title: "طبيعة الدفع",
                        hintText: "طبيعه الدفع",
                        itemList: purchasesCubit.tradeList,
                        onChanged: (value) {
                          purchasesCubit.selectedStatus = value;
                        },
                      );
                    },
                  )),
                ],
              ),
              /*   SizedBox(
                height: 20.h,
              ), */
              /*  SizedBox(
                height: 20.h,
              ), */
              BuildTextField(
                  label: "ملاحظات",
                  hint: "ملاحظات",
                  minLines: 1,
                  maxLines: 5,
                  controller: ControllerManager()
                      .getControllerByName('purchaseNotesController'),
                  icon: Icons.phone_iphone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يجب ادخال ملاحظات";
                    }
                    return null;
                  },
                  onTap: () {
                    ControllerManager()
                            .getControllerByName('purchaseNotesController')
                            .selection =
                        TextSelection(
                            baseOffset: 0,
                            extentOffset: ControllerManager()
                                .getControllerByName('purchaseNotesController')
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

  AccordionSection buildSelectedItemsList(BuildContext context) {
    return AccordionSection(
      contentBorderColor: Colors.white,
      contentBorderWidth: 0,
      accordionId: "3",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('المنتجات المختاره',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "سجل الطلبات",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor.withOpacity(0.8),
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    "تفاصيل الطلبات المختارة",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.greyColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              BlocConsumer<PurchasesCubit, PurchasesState>(
                bloc: purchasesCubit,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is AddPurchasesItemSuccess) {
                    if (state.selectedItemsList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            const Text(
                              "لا يوجد طلبات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.selectedItemsList.length,
                        itemBuilder: (context, index) {
                          final request = state.selectedItemsList[index];
                          return ExpansionTile(
                            iconColor: AppColors.lightBlueColor,
                            collapsedIconColor: AppColors.lightBlueColor,
                            maintainState: true,
                            collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Row(
                              children: [
                                Text(
                                  "كود : ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                Text(
                                  "${request.itemCode1}",
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                const Spacer(),
                                request.id == null
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
                                          "تم التأكيد",
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
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "في الانتظار",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            children: [
                              SwipeActionCell(
                                leadingActions: [
                                  SwipeAction(
                                    nestedAction: SwipeNestedAction(
                                      content: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                    content: purchasesCubit.getIconButton(
                                        Colors.red, Icons.delete),
                                    onTap: (handler) async {
                                      // Implement delete functionality
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
                                                  color: AppColors
                                                      .lightBlueColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons.filter_1_outlined,
                                                        size: 20.sp),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      "اسم المنتج: ${purchasesCubit.itemsList.firstWhere((element) => element.itemCode1 == request.itemCode1).itemNameAr}",
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
                                                    Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        size: 20.sp),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      "الكميه : ${request.qty}",
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
                                                  color: AppColors
                                                      .lightBlueColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        size: 20.sp),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      "وحدة القياس : ${purchasesCubit.uomlist.firstWhere((element) => element.uomId == request.uom).uom}",
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
                                                    Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        size: 20.sp),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      "الوصف : ${request.description}",
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
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "لا يوجد طلبات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      /* Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<PurchasesCubit, PurchasesState>(
            bloc: purchasesCubit,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AddPurchasesItemSuccess) {
                if (state.selectedItemsList.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "القائمة فارغه",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  );
                } else {}
              }
            },
          ),
        ],
      ), */
    );
  }
}
