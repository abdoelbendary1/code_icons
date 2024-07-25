import 'package:accordion/controllers.dart';
import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_DropDown_TextField.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_activity.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_company_type.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_registry_type.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_trade_office.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_valid.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/customer_data_screen.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'select_Station.dart';

class AddCustomerCardsForm extends StatefulWidget {
  const AddCustomerCardsForm({super.key});

  @override
  State<AddCustomerCardsForm> createState() => _AddCustomerCardsFormState();
}

class _AddCustomerCardsFormState extends State<AddCustomerCardsForm> {
  CustomersCubit customersCubit = CustomersCubit(
    postCustomerDataUseCase: injectPostCustomerDataUseCase(),
    fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
    fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
    fetchCurrencyByIDUseCase: injectFetchCurrencyDataByIDUseCase(),
    fetchCurrencyUseCase: iinjectFetchCurrencyUseCase(),
    fetchActivityUseCase: injectFetchActivityListUseCase(),
    fetchGeneralCentralUseCase: injectFetchGeneralCentralListUseCase(),
    fetchTradeOfficeUseCase: injectFetchTradeOfficeListUseCase(),
    fetchStationListUseCase: injectFetchStationListUseCase(),
  );

  final addCustomerControllers = ControllerManager().addCustomerControllers;

  @override
  void initState() {
    super.initState();
    ControllerManager().clearControllers(controllers: addCustomerControllers);
    customersCubit.fetchCustomers();
    customersCubit.isSubBranchSelected = false;
    customersCubit.fetchCurrencies();
    customersCubit.fetchActivities();
    customersCubit.fetchTradeOffices();
    customersCubit.fetchGeneralCentrals();
    customersCubit.fetchStations();
  }

  /* var nameKey = GlobalKey(); */

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => customersCubit,
      child: Form(
        key: customersCubit.formKey,
        child: Column(
          children: [
            Accordion(
              paddingBetweenClosedSections: 20,
              disableScrolling: true,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              contentBorderWidth: 0,
              contentBackgroundColor: Colors.transparent,
              headerBackgroundColorOpened: AppColors.greenColor,
              maxOpenSections: 1,
              headerBackgroundColor: AppColors.blueColor,
              headerPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                AccordionSection(
                  accordionId: "1",
                  leftIcon: Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                    size: 30.r,
                  ),
                  isOpen: false,
                  header: Text('بيانات العميل',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      BuildTextField(
                        label: "الاسم التجارى",
                        hint: "الاسم التجارى",
                        controller: ControllerManager()
                            .getControllerByName('brandNameBL'),
                        icon: Icons.phone_iphone,
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('brandNameBL')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName('brandNameBL')
                                      .value
                                      .text
                                      .length);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاسم التجارى";
                          }
                          return null;
                        },
                      ),
                      BuildTextField(
                        label: "الرقم القومي",
                        hint: "الرقم القومي",
                        controller: ControllerManager()
                            .getControllerByName('nationalIdBL'),
                        icon: Icons.home,
                        keyboardType: TextInputType.number,
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('nationalIdBL')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName('nationalIdBL')
                                      .value
                                      .text
                                      .length);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال الاسم الرقم القومي";
                          }
                          return null;
                        },
                      ),
                      BuildTextField(
                        label: "تاريخ الميلاد",
                        hint: "تاريخ الميلاد",
                        controller: ControllerManager()
                            .getControllerByName('birthDayBL'),
                        readOnly: true,
                        icon: Icons.app_registration,
                        onTap: () {
                          AppDatePicker.selectDate(
                              context: context,
                              controller: ControllerManager()
                                  .getControllerByName('birthDayBL'),
                              dateStorageMap: customersCubit.dateStorageMap,
                              key: "birthDayBL");
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال تاريخ الميلاد";
                          }
                          return null;
                        },
                      ),
                      BuildTextField(
                        label: AppLocalizations.of(context)!.phone_Number_label,
                        hint: AppLocalizations.of(context)!.phone_Number_hint,
                        controller:
                            ControllerManager().getControllerByName('phoneBL'),
                        icon: Icons.local_activity,
                        keyboardType: TextInputType.number,
                        onTap: () {
                          ControllerManager()
                                  .getControllerByName('phoneBL')
                                  .selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset: ControllerManager()
                                      .getControllerByName('phoneBL')
                                      .value
                                      .text
                                      .length);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يجب ادخال رقم الموبايل";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  accordionId: "2",
                  leftIcon: Icon(
                    Icons.library_books,
                    color: AppColors.whiteColor,
                    size: 30.r,
                  ),
                  isOpen: false,
                  header: Text('بيانات السجل',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          BlocConsumer<CustomersCubit, CustomersState>(
                            bloc: customersCubit,
                            listener: (context, state) {
                              if (state is FetchTradeRegistryTypesError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(state.errorMsg),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            builder: (context, state) {
                              return ReusableSelectTradeRegistryType(
                                itemList: customersCubit.tradeRegistryTypes,
                                selectedType:
                                    customersCubit.selectedTradeRegistryType,
                                onChanged: (value) {
                                  context
                                      .read<CustomersCubit>()
                                      .updateSelectedTradeRegistryType(value);
                                },
                              );
                            },
                          ),
                          BlocBuilder<CustomersCubit, CustomersState>(
                            bloc: customersCubit,
                            builder: (context, state) {
                              return Visibility(
                                visible: customersCubit.isSubBranchSelected,
                                child: BlocConsumer<CustomersCubit,
                                    CustomersState>(
                                  bloc: customersCubit,
                                  listener: (context, state) {
                                    if (state is FetchCustomersSuccess) {
                                      customersCubit.customerData =
                                          state.customers;
                                    } else if (state
                                        is LoadedCustomerByIDError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.errorMsg),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoadedCustomerByID) {
                                      return ReusableSelectTrader(
                                        itemList: customersCubit.customerData,
                                        selectedCustomer:
                                            customersCubit.selectedCustomer,
                                        onChanged: (value) {
                                          context
                                              .read<CustomersCubit>()
                                              .selectedCustomer = value!;
                                          context
                                              .read<CustomersCubit>()
                                              .fetchCustomerDataByID(
                                                  customerId:
                                                      value.idBl.toString());
                                        },
                                      );
                                    }
                                    return ReusableSelectTrader(
                                      itemList: customersCubit.customerData,
                                      selectedCustomer:
                                          customersCubit.selectedCustomer,
                                      onChanged: (value) {
                                        context
                                            .read<CustomersCubit>()
                                            .selectedCustomer = value!;
                                        context
                                            .read<CustomersCubit>()
                                            .fetchCustomerDataByID(
                                                customerId:
                                                    value.idBl.toString());
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          BuildTextField(
                              label: "تاريخ الترخيص",
                              hint: "تاريخ الترخيص",
                              controller: ControllerManager()
                                  .getControllerByName('licenseDateBL'),
                              readOnly: true,
                              icon: Icons.phone_iphone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال تاريخ الترخيص";
                                }
                                return null;
                              },
                              onTap: () {
                                AppDatePicker.selectDate(
                                    context: context,
                                    controller: ControllerManager()
                                        .getControllerByName('licenseDateBL'),
                                    dateStorageMap:
                                        customersCubit.dateStorageMap,
                                    key: "licenseDateBL");
                              }),
                          BuildTextField(
                              label: "سنه الترخيص",
                              hint: "سنه الترخيص",
                              controller: ControllerManager()
                                  .getControllerByName('licenseYearBL'),
                              icon: Icons.phone_iphone,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال سنه الترخيص";
                                }
                                return null;
                              },
                              onTap: () {
                                ControllerManager()
                                        .getControllerByName('capitalBL')
                                        .selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .getControllerByName('capitalBL')
                                            .value
                                            .text
                                            .length);
                              }),
                          BuildTextField(
                              label: "رأس المال",
                              hint: "رأس المال",
                              controller: ControllerManager()
                                  .getControllerByName('capitalBL'),
                              icon: Icons.phone_iphone,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال قيمه رأس المال";
                                }
                                return null;
                              },
                              onTap: () {
                                ControllerManager()
                                        .getControllerByName('capitalBL')
                                        .selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: ControllerManager()
                                            .getControllerByName('capitalBL')
                                            .value
                                            .text
                                            .length);
                              }),
                          Row(
                            children: [
                              Expanded(
                                child: BlocConsumer<CustomersCubit,
                                    CustomersState>(
                                  bloc: customersCubit,
                                  listener: (context, state) {
                                    if (state is FetchCurrencyError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.errorMsg),
                                        backgroundColor: Colors.red,
                                      ));
                                    } else if (state is LoadedCurrency) {
                                      state.currencyEntity =
                                          customersCubit.selectedCurrency;
                                    }
                                  },
                                  builder: (context, state) {
                                    return ReusableSelectCurrency(
                                      itemList: customersCubit.currencyData,
                                      selectedCurrency: context
                                          .read<CustomersCubit>()
                                          .selectedCurrency,
                                      onChanged: (value) {
                                        context
                                            .read<CustomersCubit>()
                                            .selectedCurrency = value!;
                                        context
                                            .read<CustomersCubit>()
                                            .fetchCurrencyDataByID(
                                                currencyId: value.id!);
                                      },
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                  child: BlocConsumer<CustomersCubit,
                                      CustomersState>(
                                bloc: customersCubit,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return ReusableSelectCompanyType(
                                    itemList: customersCubit.companyTypeList,
                                    selectedType:
                                        customersCubit.selectedCopmanyyType,
                                    onChanged: (value) {
                                      context
                                          .read<CustomersCubit>()
                                          .updateSelectedCompanyType(value);
                                    },
                                  );
                                },
                              )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AccordionSection(
                  accordionId: "3",
                  leftIcon: Icon(
                    Icons.work,
                    color: AppColors.whiteColor,
                    size: 30.r,
                  ),
                  isOpen: false,
                  header: Text('بيانات الانشطه',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: BlocConsumer<CustomersCubit,
                                    CustomersState>(
                                  bloc: customersCubit,
                                  listener: (context, state) {
                                    if (state is FetchTradeOfficeError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.errorMsg),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  builder: (context, state) {
                                    return ReusableSelectTradeOffice(
                                      itemList: customersCubit.tradeOfficeData,
                                      selectedTradeOffice:
                                          customersCubit.selectedTradeOffice,
                                      onChanged: (value) {
                                        context
                                            .read<CustomersCubit>()
                                            .selectedTradeOffice = value!;
                                        context
                                            .read<CustomersCubit>()
                                            .fetchTradeOfficeDataByID(
                                                tradeOfficeId: value.idBl!);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: BlocConsumer<CustomersCubit,
                                      CustomersState>(
                                bloc: customersCubit,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return ReusableValidType(
                                    itemList: customersCubit.validtypes,
                                    selectedType:
                                        customersCubit.selectedValidType,
                                    onChanged: (value) {
                                      context
                                          .read<CustomersCubit>()
                                          .updateSelectedValidType(value);
                                    },
                                  );
                                },
                              )),
                              Expanded(
                                child: BlocConsumer<CustomersCubit,
                                    CustomersState>(
                                  bloc: customersCubit,
                                  listener: (context, state) {
                                    if (state is FetchActivityError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.errorMsg),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  builder: (context, state) {
                                    return ReusableSelectActivity(
                                      itemList: customersCubit.activityData,
                                      selectedActivity:
                                          customersCubit.selectedActivity,
                                      onChanged: (value) {
                                        context
                                            .read<CustomersCubit>()
                                            .selectedActivity = value!;
                                        context
                                            .read<CustomersCubit>()
                                            .fetchAvtivityDataByID(
                                                activityId: value.idBl!);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          BuildTextField(
                              label: "النشاط",
                              hint: "النشاط",
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
                              label:
                                  AppLocalizations.of(context)!.address_label,
                              hint: AppLocalizations.of(context)!.address_hint,
                              controller: ControllerManager()
                                  .getControllerByName('addressBL'),
                              icon: Icons.phone_iphone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يجب ادخال العنوان";
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
                          BuildTextField(
                              label: "المالك",
                              hint: "المالك",
                              controller: ControllerManager()
                                  .getControllerByName('ownerBL'),
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
                          BlocConsumer<CustomersCubit, CustomersState>(
                            bloc: customersCubit,
                            listener: (context, state) {
                              if (state is FetchStationError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(state.errorMsg),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            builder: (context, state) {
                              return ReusableSelectStation(
                                itemList: customersCubit.stationData,
                                selectedStation: customersCubit.selectedStation,
                                onChanged: (value) {
                                  context
                                      .read<CustomersCubit>()
                                      .selectedStation = value!;
                                  context
                                      .read<CustomersCubit>()
                                      .fetchStationDataByID(
                                          stationId: value.idBl!);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                const Spacer(),
                BlocListener<CustomersCubit, CustomersState>(
                  bloc: customersCubit,
                  listener: (context, state) {
                    if (state is AddCustomerSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "تمت الإضافه بنجاح",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: AppColors.greenColor,
                        duration: Durations.extralong1,
                      ));
                      Navigator.pushReplacementNamed(
                          context, CustomerDataScreen.routeName);
                    } else if (state is AddCustomerError) {
                      if (state.errorMsg.contains("400")) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "برجاء ادخال البيانات صحيحه",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        ));
                        print(state.errorMsg);
                      } else if (state.errorMsg.contains("500")) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "حدث خطأ ما",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          backgroundColor: AppColors.redColor,
                          duration: Durations.extralong1,
                        ));
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
                        CustomerDataModel customerData = customersCubit
                            .createCustomerDataModelFromControllers(
                                addCustomerControllers, context);
                        customersCubit.addCustomer(customerData, context);
                        print(
                            "customerData.activityBl: ${customerData.activityBl}");
                        print(
                            "customerData.activityNameBl: ${customerData.activityNameBl}");
                        print(
                            "customerData.addressBl: ${customerData.addressBl}");
                        print(
                            "customerData.birthDayBl: ${customerData.birthDayBl}");
                        print(
                            "customerData.brandNameBl: ${customerData.brandNameBl}");
                        print(
                            "customerData.capitalBl: ${customerData.capitalBl}");
                        print(
                            "customerData.companyTypeBl: ${customerData.companyTypeBl}");
                        print(
                            "customerData.companyTypeNameBl: ${customerData.companyTypeNameBl}");
                        print(
                            "customerData.currencyIdBl: ${customerData.currencyIdBl}");
                        print(
                            "customerData.customerDataIdBl: ${customerData.customerDataIdBl}");
                        print(
                            "customerData.divisionBl: ${customerData.divisionBl}");
                        print(
                            "customerData.expiredBl: ${customerData.expiredBl}");
                        print("customerData.idBl: ${customerData.idBl}");
                        print(
                            "customerData.licenseDateBl: ${customerData.licenseDateBl}");
                        print(
                            "customerData.licenseYearBl: ${customerData.licenseYearBl}");
                        print(
                            "customerData.nationalIdBl: ${customerData.nationalIdBl}");
                        print(
                            "customerData.numExpiredBl: ${customerData.numExpiredBl}");
                        print("customerData.ownerBl: ${customerData.ownerBl}");
                        print("customerData.phoneBl: ${customerData.phoneBl}");
                        print(
                            "customerData.stationBl: ${customerData.stationBl}");
                        print(
                            "customerData.stationNameBl: ${customerData.stationNameBl}");
                        print(
                            "customerData.tradeOfficeBl: ${customerData.tradeOfficeBl}");
                        print(
                            "customerData.tradeOfficeNameBl: ${customerData.tradeOfficeNameBl}");
                        print(
                            "customerData.tradeRegistryBl: ${customerData.tradeRegistryBl}");
                        print(
                            "customerData.tradeRegistryTypeBl: ${customerData.tradeRegistryTypeBl}");
                        print(
                            "customerData.tradeTypeBl: ${customerData.tradeTypeBl}");
                        print("customerData.validBl: ${customerData.validBl}");
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
