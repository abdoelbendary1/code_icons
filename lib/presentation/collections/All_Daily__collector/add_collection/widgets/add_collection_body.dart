import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/cubit/add_collection_cubit.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/widgets/collection_details_form.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntity.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityName.dart';
import 'package:code_icons/presentation/purchases/PurchaseRequest/widgets/SelectCustomerEntityRegistryNum.dart';
import 'package:code_icons/presentation/utils/dialogUtils.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/services/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddCollectionBody extends StatefulWidget {
  AddCollectionBody({super.key});

  @override
  State<AddCollectionBody> createState() => _AddCollectionBodyState();
}

class _AddCollectionBodyState extends State<AddCollectionBody> {
  AddCollectionCubit addCollectionCubit = AddCollectionCubit(
      fetchCustomerDataUseCase: injectFetchCustomerDataUseCase(),
      fetchCustomerDataByIDUseCase: injectFetchCustomerByIdDataUseCase(),
      fetchPaymentValuesUseCase: injectFetchPaymentValuesUseCase(),
      postTradeCollectionUseCase: injectPostTradeCollectionUseCase(),
      paymentValuesByIdUseCase: injectPostPaymentValuesByIdUseCase());

  @override
  void initState() {
    super.initState();
    addCollectionCubit.fetchCustomerDataPages(skip: 10, take: 20);
    ControllerManager().clearControllers(
        controllers: ControllerManager().addCollectionControllers);
    /* addCollectionCubit.getReciets(); */
    /*  RecietCollctionCubit.recietCubit.selectRecietCollection(); */
  }

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AddCollectionBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addCollectionCubit,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 16.0.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<AddCollectionCubit, AddCollectionState>(
          listener: (context, state) {
            if (state is GetAllCustomerDataSuccess) {
              addCollectionCubit.customerData = state.customerData!;
              addCollectionCubit.receipts = state.receipts ?? [];
            } else if (state is GetAllCustomerDataError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMsg,
                titleColor: AppColors.redColor,
              );
            } else if (state is GetCustomerDataByIDError) {
              if (state.errorMsg == "تأكد من اتصالك بالانترنت") {
                ControllerManager().clearControllers(
                    controllers: ControllerManager().addCollectionControllers);

                QuickAlert.show(
                  animType: QuickAlertAnimType.slideInUp,
                  context: context,
                  type: QuickAlertType.error,
                  showConfirmBtn: false,
                  title: state.errorMsg,
                  titleColor: AppColors.redColor,
                );
              }
            } else if (state is GetpaymentValuesByIDError) {
              ControllerManager().clearControllers(
                  controllers: ControllerManager().addCollectionControllers);
              QuickAlert.show(
                animType: QuickAlertAnimType.slideInUp,
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMsg,
                titleColor: AppColors.redColor,
                /* text: state.errorMsg, */
              );
            }
          },
          builder: (context, state) {
            if (state is GetAllCustomerDataLoading) {
              return Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  LoadingStateAnimation(),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<AddCollectionCubit, AddCollectionState>(
                  listener: (context, state) {},
                  //get the payment reciet
                  bloc: addCollectionCubit,
                  buildWhen: (previous, current) {
                    if (previous is GetCustomerDataByIDSuccess) {
                      return false;
                    }
                    if (current is YearsUpdatedState) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                  builder: (context, state) {
                    if (state is GetCustomerDataByIDSuccess) {
                      return Column(
                        children: [
                          SelectCustomerEntityName(
                            initialItem: addCollectionCubit.selectedCustomer,
                            itemList: addCollectionCubit.customerData,
                            title: "اسم التاجر",
                            hintText: "اسم التاجر",
                            /*  headerFontSize: 25.sp, */
                            onChanged: (value) {
                              context
                                  .read<AddCollectionCubit>()
                                  .selectedCustomer = value;
                              context
                                  .read<AddCollectionCubit>()
                                  .fetchCustomerDataByID(
                                      customerId: context
                                          .read<AddCollectionCubit>()
                                          .selectedCustomer
                                          .idBl
                                          .toString());
                            },
                          ),
                          SelectCustomerEntityRegistryNum(
                            initialItem: addCollectionCubit.selectedCustomer,
                            itemList: addCollectionCubit.customerData,
                            title: "رقم السجل",
                            hintText: "رقم السجل",
                            /*  headerFontSize: 25.sp, */
                            onChanged: (value) {
                              context
                                  .read<AddCollectionCubit>()
                                  .selectedCustomer = value;
                              context
                                  .read<AddCollectionCubit>()
                                  .fetchCustomerDataByID(
                                      customerId: context
                                          .read<AddCollectionCubit>()
                                          .selectedCustomer
                                          .idBl
                                          .toString());
                            },
                          ),
                        ],
                      );
                    } else if (state is GetCustomerDataByIDLoading) {
                      return Center(
                          child: SizedBox(
                              height: 400.h, child: LoadingStateAnimation()));
                    }
                    return Column(
                      children: [
                        SelectCustomerEntityName(
                          initialItem: context
                              .read<AddCollectionCubit>()
                              .selectedCustomer,
                          itemList:
                              context.read<AddCollectionCubit>().customerData,
                          title: "اسم التاجر",
                          hintText: "اسم التاجر",
                          /*  headerFontSize: 25.sp, */
                          onChanged: (value) {
                            try {
                              context
                                  .read<AddCollectionCubit>()
                                  .selectedCustomer = value;
                              context
                                  .read<AddCollectionCubit>()
                                  .fetchCustomerDataByID(
                                      customerId: context
                                          .read<AddCollectionCubit>()
                                          .selectedCustomer
                                          .idBl
                                          .toString());
                            } catch (e) {}
                          },
                        ),
                        SelectCustomerEntityRegistryNum(
                          overlayController: addCollectionCubit
                              .overlayPortalRegistryController,
                          initialItem: context
                              .read<AddCollectionCubit>()
                              .selectedCustomer,
                          itemList:
                              context.read<AddCollectionCubit>().customerData,
                          title: "رقم السجل",
                          hintText: "رقم السجل",
                          /*  headerFontSize: 25.sp, */
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read<AddCollectionCubit>()
                                  .selectedCustomer = value;
                              context
                                  .read<AddCollectionCubit>()
                                  .fetchCustomerDataByID(
                                      customerId: context
                                          .read<AddCollectionCubit>()
                                          .selectedCustomer
                                          .idBl
                                          .toString());
                            }
                          },
                        ),
                      ],
                    );

                    /*     return Column(
                      children: [
                        SelectCustomerEntityName(
                          initialItem: context
                              .read<AddCollectionCubit>()
                              .selectedCustomer,
                          itemList:
                              context.read<AddCollectionCubit>().customerData,
                          title: "اسم التاجر",
                          hintText: "اسم التاجر",
                          /*  headerFontSize: 25.sp, */
                          onChanged: (value) {
                            context
                                .read<AddCollectionCubit>()
                                .selectedCustomer = value;
                            context
                                .read<AddCollectionCubit>()
                                .fetchCustomerDataByID(
                                    customerId: context
                                        .read<AddCollectionCubit>()
                                        .selectedCustomer
                                        .idBl
                                        .toString());
                          },
                        ),
                        SelectCustomerEntityRegistryNum(
                          initialItem: context
                              .read<AddCollectionCubit>()
                              .selectedCustomer,
                          itemList:
                              context.read<AddCollectionCubit>().customerData,
                          title: "رقم السجل",
                          hintText: "رقم السجل",
                          /*  headerFontSize: 25.sp, */
                          onChanged: (value) {
                            context
                                .read<AddCollectionCubit>()
                                .selectedCustomer = value;
                            context
                                .read<AddCollectionCubit>()
                                .fetchCustomerDataByID(
                                    customerId: context
                                        .read<AddCollectionCubit>()
                                        .selectedCustomer
                                        .idBl
                                        .toString());
                          },
                        ),
                      ],
                    );
                   */
                  },
                ),
                BlocConsumer<AddCollectionCubit, AddCollectionState>(
                  bloc: addCollectionCubit
                    ..initialize(
                        controller: 'addCollectionPaymentReceitController'),
                  listener: (context, state) {
                    // Add debug print
                    if (state is GetpaymentValuesByIDError) {
                      /*  MotionToast(
                        icon: Icons.zoom_out,
                        primaryColor: Colors.deepOrange,
                        title: Text("Top Motion Toast"),
                        description: Text("Another motion toast example"),
                        position: MotionToastPosition.top,
                        animationType: AnimationType.fromTop,
                      ).show(context); */
                      /*  MotionToast.error(
                              title: Text("Error"),
                              description: Text(state.errorMsg))
                          .show(context); */
                    }
                  },
                  builder: (context, state) {
                    print("Builder State: $state");
                    /*   if (state is GetCustomerDataByIDInitial) {
                      return Center(
                          child: SizedBox(
                              height: 200, child: LoadingStateAnimation()));
                    } /* else if (state is GetCustomerDataByIDError) {
                      print(state.errorMsg);
                      return Center(child: Text(state.errorMsg));
                    }  */
                    else if (state is GetCustomerDataByIDSuccess ||
                        state is YearsUpdatedState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          CollectionDetailsForm(),
                        ],
                      );
                    } else {
                      return Container();
                    } */
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        CollectionDetailsForm(),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
