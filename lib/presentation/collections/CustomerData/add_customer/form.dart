// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_DropDown_TextField.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/selectCurrency.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_Station.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_activity.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_company_type.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_registry_type.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_trade_office.dart';
import 'package:code_icons/presentation/collections/CustomerData/add_customer/widgets/select_valid.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/collections/CustomerData/customer_data_screen.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/Reusable_Custom_TextField.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddCustomerForm extends StatefulWidget {
  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => customersCubit,
      child: Form(
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
              _buildTextField(
                  "الاسم التجارى",
                  "الاسم التجارى",
                  ControllerManager().getControllerByName('brandNameBL'),
                  Icons.phone_iphone,
                  () {}),
              _buildTextField(
                  "الرقم القومي",
                  "الرقم القومي",
                  ControllerManager().getControllerByName('nationalIdBL'),
                  Icons.home,
                  keyboardType: TextInputType.number,
                  () {}),
              _buildTextField(
                "تاريخ الميلاد",
                "تاريخ الميلاد",
                readOnly: true,
                ControllerManager().getControllerByName('birthDayBL'),
                Icons.app_registration,
                () {
                  AppDatePicker.selectDate(
                      context: context,
                      controller:
                          ControllerManager().getControllerByName('birthDayBL'),
                      dateStorageMap: customersCubit.dateStorageMap,
                      key: "birthDayBL");
                },
              ),
              _buildTextField(
                  AppLocalizations.of(context)!.phone_Number_label,
                  AppLocalizations.of(context)!.phone_Number_hint,
                  ControllerManager().getControllerByName('phoneBL'),
                  Icons.local_activity,
                  keyboardType: TextInputType.number,
                  () {}),
              BlocConsumer<CustomersCubit, CustomersState>(
                bloc: customersCubit,
                listener: (context, state) {
                  if (state is FetchTradeRegistryTypesError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) {
                  return ReusableSelectTradeRegistryType(
                    itemList: customersCubit.tradeRegistryTypes,
                    selectedType: customersCubit.selectedTradeRegistryType,
                    onChanged: (value) {
                      setState(() {
                        context
                            .read<CustomersCubit>()
                            .selectedTradeRegistryType = value;
                        customersCubit.isSubBranchSelected =
                            value?['type'] == "فرعي";
                        /* if (customersCubit.isSubBranchSelected == true) {
                          ControllerManager().clearControllers(
                              controllers: addCustomerControllers);
                        } */
                      });
                    },
                  );
                },
              ),
              /* if (customersCubit.isSubBranchSelected) */
              Visibility(
                visible: customersCubit.isSubBranchSelected,
                child: BlocConsumer<CustomersCubit, CustomersState>(
                  bloc: customersCubit,
                  listener: (context, state) {
                    if (state is FetchCustomersSuccess) {
                      customersCubit.customerData = state.customers;
                    } else if (state is LoadedCustomerByIDError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadCustomerByID ||
                        state is LoadedCustomerByIDError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is LoadedCustomerByID) {
                      return ReusableSelectTrader(
                        label: "يتبع",
                        itemList: customersCubit.customerData,
                        selectedCustomer: customersCubit.selectedCustomer,
                        onChanged: (value) {
                          context.read<CustomersCubit>().selectedCustomer =
                              value!;
                          context.read<CustomersCubit>().fetchCustomerDataByID(
                              customerId: value.idBl.toString());
                        },
                      );
                    }
                    return ReusableSelectTrader(
                      label: "يتبع",
                      itemList: customersCubit.customerData,
                      selectedCustomer: customersCubit.selectedCustomer,
                      onChanged: (value) {
                        context.read<CustomersCubit>().selectedCustomer =
                            value!;
                        context.read<CustomersCubit>().fetchCustomerDataByID(
                            customerId: value.idBl.toString());
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        if (state is FetchCurrencyError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        } else if (state is LoadedCurrency) {
                          state.currencyEntity =
                              customersCubit.selectedCurrency;
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadCurrency) {
                          return Center(
                            child: SizedBox(
                                height: 30, child: LoadingStateAnimation()),
                          );
                        }

                        return ReusableSelectCurrency(
                          itemList: customersCubit.currencyData,
                          selectedCurrency:
                              context.read<CustomersCubit>().selectedCurrency,
                          onChanged: (value) {
                            /*  setState(() {
                            }); */
                            /*  context.read<CustomersCubit>().selectedCurrency =
                                value!; */
                            context.read<CustomersCubit>().selectedCurrency =
                                value!;
                            context
                                .read<CustomersCubit>()
                                .fetchCurrencyDataByID(currencyId: value.id!);
                            customersCubit.changeCurrency(value);
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        if (state is FetchActivityError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadActivity) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ReusableSelectActivity(
                          itemList: customersCubit.activityData,
                          selectedActivity: customersCubit.selectedActivity,
                          onChanged: (value) {
                            setState(() {
                              customersCubit.selectedActivity = value!;
                            });
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
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        if (state is FetchTradeOfficeError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadTradeOffice) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ReusableSelectTradeOffice(
                          itemList: customersCubit.tradeOfficeData,
                          selectedTradeOffice:
                              customersCubit.selectedTradeOffice,
                          onChanged: (value) {
                            setState(() {
                              customersCubit.selectedTradeOffice = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  /*   Expanded(
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        if (state is FetchGeneralCentralError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadGeneralCentral) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ReusableSelectGeneralCentral(
                          itemList: customersCubit.generalCentralData,
                          selectedGeneralCentral:
                              customersCubit.selectedGeneralCentral,
                          onChanged: (value) {
                            setState(() {
                              customersCubit.selectedGeneralCentral = value!;
                            });
                          },
                        );
                      },
                    ),
                  ), */
                ],
              ),
              _buildTextField(
                  "تاريخ الترخيص",
                  "تاريخ الترخيص",
                  readOnly: true,
                  ControllerManager().getControllerByName('licenseDateBL'),
                  Icons.phone_iphone, () {
                AppDatePicker.selectDate(
                    context: context,
                    controller: ControllerManager()
                        .getControllerByName('licenseDateBL'),
                    dateStorageMap: customersCubit.dateStorageMap,
                    key: "licenseDateBL");
              }),
              _buildTextField(
                  "سنه الترخيص",
                  "سنه الترخيص",
                  ControllerManager().getControllerByName('licenseYearBL'),
                  Icons.phone_iphone,
                  keyboardType: TextInputType.number,
                  () {}),
              _buildTextField(
                  "رأس المال",
                  "رأس المال",
                  ControllerManager().getControllerByName('capitalBL'),
                  Icons.phone_iphone,
                  keyboardType: TextInputType.number,
                  () {}),
              Row(
                children: [
                  Expanded(
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        /*   if (state is FetchTradeRegistryTypesError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        } */
                      },
                      builder: (context, state) {
                        return ReusableSelectCompanyType(
                          itemList: customersCubit.companyTypeList,
                          selectedType: customersCubit.selectedCopmanyyType,
                          onChanged: (value) {
                            setState(() {
                              customersCubit.selectedCopmanyyType = value;
                              /* customersCubit.isSubBranchSelected =
                                  value?['type'] == "فرعي"; */
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<CustomersCubit, CustomersState>(
                      bloc: customersCubit,
                      listener: (context, state) {
                        /*  if (state is FetchTradeRegistryTypesError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ));
                        } */
                      },
                      builder: (context, state) {
                        return ReusableValidType(
                          itemList: customersCubit.validtypes,
                          selectedType: customersCubit.selectedValidType,
                          onChanged: (value) {
                            setState(() {
                              customersCubit.selectedValidType = value;
                              /* customersCubit.isSubBranchSelected =
                                  value?['type'] == "فرعي"; */
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              _buildTextField(
                  "النشاط",
                  "النشاط",
                  ControllerManager().getControllerByName('divisionBL'),
                  Icons.diversity_3_sharp,
                  () {}),
              _buildTextField(
                  AppLocalizations.of(context)!.address_label,
                  AppLocalizations.of(context)!.address_hint,
                  ControllerManager().getControllerByName('addressBL'),
                  Icons.phone_iphone,
                  () {}),
              _buildTextField(
                  "المالك",
                  "المالك",
                  ControllerManager().getControllerByName('ownerBL'),
                  Icons.phone_iphone,
                  () {}),
              BlocConsumer<CustomersCubit, CustomersState>(
                bloc: customersCubit,
                listener: (context, state) {
                  if (state is FetchStationError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is LoadStation) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ReusableSelectStation(
                    itemList: customersCubit.stationData,
                    selectedStation: customersCubit.selectedStation,
                    onChanged: (value) {
                      setState(() {
                        customersCubit.selectedStation = value!;
                      });
                    },
                  );
                },
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
                    },
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
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon,
    void Function()? onTap, {
    bool? readOnly = false,
    void Function(String)? onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      children: [
        ReusableCustomTextField(
          /*  labelText: label, */
          hintText: hint,
          controller: controller,
          prefixIcon: icon,
          onTap: onTap,
          readOnly: readOnly,
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
        SizedBox(height: 25.h),
      ],
    );
  }

  Future<void> _selectDate(
      {required BuildContext context,
      required TextEditingController controller,
      required Map<String, String> dateStorageMap,
      required String key}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header background color
            hintColor: Colors.blueAccent, // Selected date background color
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header background color and selected date
              onPrimary: Colors.white, // Header text color
              surface: Colors.blue[50]!, // Background color of the calendar
              onSurface: Colors.blueGrey, // Calendar text color
            ),
            dialogBackgroundColor:
                Colors.blue[100], // Background color of the dialog
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      // Store the picked date in '1984-01-31T22:00:00' format
      String storedDate = pickedDate.toIso8601String();

      // Format the date to 'yyyy-MM-dd' for display
      String displayDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      controller.text = displayDate;

      // Store the date in the map based on the key
      dateStorageMap[key] = storedDate;
    }
  }
}
