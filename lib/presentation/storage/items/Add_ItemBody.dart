import 'package:accordion/accordion.dart';

import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/response/storage/itemCategory/item_category_dm.dart';
import 'package:code_icons/data/model/response/storage/itemCompany/item_company_dm.dart';
import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/Sales/Invoice/editInvoice/EditSales_Invoice.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectableDropDownlist.dart';
import 'package:code_icons/presentation/storage/StorageScreen.dart';
import 'package:code_icons/presentation/storage/items/cubit/items_cubit.dart';
import 'package:code_icons/presentation/storage/items/storageBody.dart';
import 'package:code_icons/presentation/storage/widgets/selectCategory.dart';
import 'package:code_icons/presentation/storage/widgets/selectCompany.dart';
import 'package:code_icons/presentation/storage/widgets/select_ItemUOM.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddItemBody extends StatefulWidget {
  const AddItemBody({super.key});

  @override
  State<AddItemBody> createState() => _AddItemBodyState();
}

class _AddItemBodyState extends State<AddItemBody> {
  ItemsCubit itemsCubit = ItemsCubit(
    fetchUOMUsecase: injectFetchUOMUseCase(),
    addItemUseCase: injcetAddItemUseCase(),
    addItemCategoryUseCase: injectAddItemCategoryUseCase(),
    itemCompanyUseCase: injcetAddItemCompanyUseCase(),
  );
  ControllerManager controllerManager = ControllerManager();
  @override
  void initState() {
    super.initState();

    itemsCubit.initialze();
    controllerManager.clearControllers(
        controllers: controllerManager.itemControllers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => itemsCubit,
      child: Form(
        key: itemsCubit.formKey,
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildSaveButton(
                    mainAxisAlignment: MainAxisAlignment.end,
                    title: AppLocalizations.of(context)!.save,
                    context: context,
                    onPressed: () async {
                      itemsCubit.addItem(item: itemsCubit.createItem());
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
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
      header: const Text('وحدات القياس',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      content: BlocConsumer<ItemsCubit, ItemsState>(
        bloc: itemsCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SelectItemEntityUOM(
                      validator: (value) {
                        if (value == null) {
                          return "يجب ادخال الوحده";
                        }
                        return null;
                      },
                      title: "وحدة القياس",
                      hintText: "اختيار وحدة القياس",
                      itemList: itemsCubit.uomlist,
                      initialItem: itemsCubit.uomlist.isNotEmpty
                          ? itemsCubit.uomlist.first
                          : null, // Handle empty list
                      onChanged: (value) {
                        itemsCubit.selectedUom = value;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: BuildTextField(
                      label: "سعر الشراء",
                      hint: "سعر الشراء",
                      keyboardType: TextInputType.number,
                      controller: controllerManager.itemSmallUomPriceP,
                      icon: Icons.diversity_3_sharp,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "لا يمكن ترك الحقل فارغاً";
                        }
                        return null;
                      },
                      onTap: () {
                        controllerManager.itemSmallUomPriceP.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .itemSmallUomPriceP.value.text.length,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BuildTextField(
                      label: "سعر البيع",
                      hint: "سعر البيع",
                      keyboardType: TextInputType.number,
                      controller: controllerManager.itemSmallUomPriceS,
                      icon: Icons.diversity_3_sharp,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "لا يمكن ترك الحقل فارغاً";
                        }
                        return null;
                      },
                      onTap: () {
                        controllerManager.itemSmallUomPriceS.selection =
                            TextSelection(
                          baseOffset: 0,
                          extentOffset: controllerManager
                              .itemSmallUomPriceS.value.text.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
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
        BlocListener<ItemsCubit, ItemsState>(
          bloc: itemsCubit,
          listener: (context, state) {
            if (state is AddItemSuccess) {
              DialogUtils.hideLoading(context);

              DialogUtils.hideLoading(context);
              /* Navigator.popAndPushNamed(context, EditSalesInvoice.routeName,
                  arguments: state.invoiceId); */
              /*      Navigator.pushReplacementNamed(context, AddItemsScreen.routeName); */
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.success,
                showConfirmBtn: false,
                title: "تمت الاضافه بنجاح",
                titleColor: AppColors.greenColor,
                /* text: state.errorMsg, */
              );
            } else if (state is AddItemLoading) {
              DialogUtils.showLoading(
                  context: context, message: "state.loadingMessege");
            }
            if (state is AddItemError) {
              DialogUtils.hideLoading(context);
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMsg,
                titleColor: AppColors.redColor,
                /* text: state.errorMsg, */
              );
              if (state.errorMsg.contains("400")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                  /* text: state.errorMsg, */
                );
              } else if (state.errorMsg.contains("500")) {
                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                  /* text: state.errorMsg, */
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

  AccordionSection buildInvoiceInfoSection(BuildContext context) {
    return AccordionSection(
      accordionId: "1",
      leftIcon: Icon(
        Icons.work,
        color: AppColors.whiteColor,
        size: 30.r,
      ),
      isOpen: false,
      header: const Text('بيانات الصنف',
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
                      label: "اسم الصنف باللغه العربية",
                      hint: "اسم الصنف باللغه العربية",
                      controller: controllerManager.itemNameAr,
                      icon: Icons.diversity_3_sharp,
                      /*   validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "لا يمكن ترك الحقل فارغاً";
                        }
                        return null;
                      }, */
                      onTap: () {
                        controllerManager.itemNameAr.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset:
                              controllerManager.itemNameAr.value.text.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocConsumer<ItemsCubit, ItemsState>(
                    bloc: itemsCubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SelectableDropDownlist(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال نوع الصنف";
                          }
                          return null;
                        },
                        title: "نوع الصنف",
                        hintText: "نوع الصنف",
                        itemList: itemsCubit.Types,
                        initialItem: itemsCubit.Types.isNotEmpty
                            ? itemsCubit.Types.first
                            : null, // Handle empty list
                        onChanged: (value) {
                          /* itemsCubit.selectedType = value; */
                          itemsCubit.getIdByName(value, itemsCubit.Type);
                        },
                      );
                    },
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: BlocBuilder<ItemsCubit, ItemsState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: SelectCategoryEntity(
                                validator: (value) {
                                  if (value == null) {
                                    return "يجب ادخال الفئه";
                                  }
                                  return null;
                                },
                                title: "فئة الصنف",
                                hintText: "فئة الصنف",
                                itemList: itemsCubit.categoriesList,
                                initialItem:
                                    itemsCubit.categoriesList.isNotEmpty
                                        ? itemsCubit.categoriesList.first
                                        : null, // Handle empty list
                                onChanged: (value) {
                                  itemsCubit.selectedItemCategoryEntity = value;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: BlocConsumer<ItemsCubit, ItemsState>(
                        bloc: itemsCubit,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 45.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: AppColors.blueColor,
                                  minimumSize: Size.fromHeight(60.h),
                                ),
                                onPressed: () {
                                  controllerManager
                                      .invoiceAddCustomerNameController
                                      .clear();
                                  controllerManager
                                      .invoiceAddCustomerCountryController
                                      .clear();
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    backgroundColor: AppColors.whiteColor,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 12.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              /*      // BuildTextField for invoice source code
                                              BuildTextField(
                                                label: "كود",
                                                hint: "كود",
                                                controller: controllerManager
                                                    .invoiceAddCustomerNameController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddCustomerNameController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddCustomerNameController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ), */
                                              BuildTextField(
                                                label: "الاسم باللغة العربية",
                                                hint: "الاسم باللغة العربية",
                                                controller: controllerManager
                                                    .invoiceAddItemCategoryNameArController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddItemCategoryNameArController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddItemCategoryNameArController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 45.h,
                                              ),
                                              buildSaveButton(
                                                  context: context,
                                                  onPressed: () {
                                                    itemsCubit.postItemCategory(
                                                        itemCategoryDm: ItemCategoryDm(
                                                            catNameAr:
                                                                controllerManager
                                                                    .invoiceAddItemCategoryNameArController
                                                                    .text));
                                                    /*     InvoiceCustomerDm
                                                        invoiceCustomer =
                                                        InvoiceCustomerDm(
                                                      accountId: 56,
                                                      cusCode: 1,
                                                      cusNameAr: controllerManager
                                                          .invoiceAddCustomerTaxNumController
                                                          .text,
                                                      cusNameEn: null,
                                                      tel: null,
                                                      mobile: controllerManager
                                                          .invoiceAddCustomerPhoneController
                                                          .text,
                                                      address: null,
                                                      maxCredit: 0,
                                                      discountRatio: 0,
                                                      city: null,
                                                      email: null,
                                                      fax: null,
                                                      zip: null,
                                                      shipping: null,
                                                      manager: null,
                                                      dueDaysCount: null,
                                                      representative: null,
                                                      representativeJob: null,
                                                      categoryId: 1,
                                                      taxCardNumber:
                                                          controllerManager
                                                              .invoiceAddCustomerNameController
                                                              .text,
                                                      taxFileNumber: null,
                                                      tradeRegistry: null,
                                                      taxDepartment: null,
                                                      isTaxable: true,
                                                      idNumber: null,
                                                      bankName: null,
                                                      bankAccNum: null,
                                                      isBlocked: false,
                                                      isActive: false,
                                                      groupId: 1,
                                                      repMobile: null,
                                                      repId: null,
                                                      region: null,
                                                      csType: 0,
                                                      street: null,
                                                      neighborhood: null,
                                                      countryId:
                                                          salesInvoiceCubit
                                                              .countryCode,
                                                      governate: null,
                                                      buildingNumber: null,
                                                      subArea: null,
                                                      priceLevelId: null,
                                                      knowUs: null,
                                                      stopped: false,
                                                      insertDate:
                                                          "2024-09-25T21:55:19.49217",
                                                    );
                                                    salesInvoiceCubit
                                                        .addCustomer(
                                                            invoiceCustomer,
                                                            context); */
                                                  },
                                                  title: "إضافه",
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.whiteColor,
                                  size: 25,
                                ),
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
              Row(
                children: [
                  BlocConsumer<ItemsCubit, ItemsState>(
                    bloc: itemsCubit,
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Expanded(
                        flex: 8,
                        child: SelectCompanyEntity(
                          validator: (value) {
                            if (value == null) {
                              return "يجب ادخال المجموعه";
                            }
                            return null;
                          },
                          title: "مجموعه الصنف",
                          hintText: "مجموعه الصنف",
                          itemList: itemsCubit.companiesList,
                          initialItem: itemsCubit.companiesList.isNotEmpty
                              ? itemsCubit.companiesList.first
                              : null, // Handle empty list
                          onChanged: (value) {
                            itemsCubit.selectedItemCompanyEntity = value;
                          },
                        ),
                      );
                    },
                  ),
                  Expanded(
                      flex: 2,
                      child: BlocConsumer<ItemsCubit, ItemsState>(
                        bloc: itemsCubit,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 45.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: AppColors.blueColor,
                                  minimumSize: Size.fromHeight(60.h),
                                ),
                                onPressed: () {
                                  controllerManager
                                      .invoiceAddCustomerNameController
                                      .clear();
                                  controllerManager
                                      .invoiceAddCustomerCountryController
                                      .clear();
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    backgroundColor: AppColors.whiteColor,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 12.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              // BuildTextField for invoice source code
                                              /*    BuildTextField(
                                                label: "كود",
                                                hint: "كود",
                                                controller: controllerManager
                                                    .invoiceAddCustomerNameController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddCustomerNameController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddCustomerNameController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ), */
                                              BuildTextField(
                                                label: "الاسم باللغة العربية",
                                                hint: "الاسم باللغة العربية",
                                                controller: controllerManager
                                                    .invoiceAddItemCompanyNameArController,
                                                icon: Icons.person,
                                                /*   validator: (value) {
                                                                if (value == null || value.trim().isEmpty) {
                                                                  return "لا يمكن ترك الحقل فارغاً";
                                                                }
                                                                return null;
                                                              }, */
                                                onTap: () {
                                                  controllerManager
                                                      .invoiceAddItemCompanyNameArController
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: controllerManager
                                                        .invoiceAddItemCompanyNameArController
                                                        .value
                                                        .text
                                                        .length,
                                                  );
                                                },
                                              ),

                                              SizedBox(
                                                height: 45.h,
                                              ),
                                              buildSaveButton(
                                                  context: context,
                                                  onPressed: () {
                                                    itemsCubit.postItemCompany(
                                                        itemCompanyDm: ItemCompanyDm(
                                                            comNameAr:
                                                                controllerManager
                                                                    .invoiceAddItemCompanyNameArController
                                                                    .text));
                                                    /*     InvoiceCustomerDm
                                                        invoiceCustomer =
                                                        InvoiceCustomerDm(
                                                      accountId: 56,
                                                      cusCode: 1,
                                                      cusNameAr: controllerManager
                                                          .invoiceAddCustomerTaxNumController
                                                          .text,
                                                      cusNameEn: null,
                                                      tel: null,
                                                      mobile: controllerManager
                                                          .invoiceAddCustomerPhoneController
                                                          .text,
                                                      address: null,
                                                      maxCredit: 0,
                                                      discountRatio: 0,
                                                      city: null,
                                                      email: null,
                                                      fax: null,
                                                      zip: null,
                                                      shipping: null,
                                                      manager: null,
                                                      dueDaysCount: null,
                                                      representative: null,
                                                      representativeJob: null,
                                                      categoryId: 1,
                                                      taxCardNumber:
                                                          controllerManager
                                                              .invoiceAddCustomerNameController
                                                              .text,
                                                      taxFileNumber: null,
                                                      tradeRegistry: null,
                                                      taxDepartment: null,
                                                      isTaxable: true,
                                                      idNumber: null,
                                                      bankName: null,
                                                      bankAccNum: null,
                                                      isBlocked: false,
                                                      isActive: false,
                                                      groupId: 1,
                                                      repMobile: null,
                                                      repId: null,
                                                      region: null,
                                                      csType: 0,
                                                      street: null,
                                                      neighborhood: null,
                                                      countryId:
                                                          salesInvoiceCubit
                                                              .countryCode,
                                                      governate: null,
                                                      buildingNumber: null,
                                                      subArea: null,
                                                      priceLevelId: null,
                                                      knowUs: null,
                                                      stopped: false,
                                                      insertDate:
                                                          "2024-09-25T21:55:19.49217",
                                                    );
                                                    salesInvoiceCubit
                                                        .addCustomer(
                                                            invoiceCustomer,
                                                            context); */
                                                  },
                                                  title: "إضافه",
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.whiteColor,
                                  size: 25,
                                ),
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
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
