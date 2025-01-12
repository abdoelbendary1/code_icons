import 'package:code_icons/presentation/ships/AddReport/cubit/add_ship_report_cubit.dart';
import 'package:code_icons/presentation/ships/AddReport/form_details.dart';
import 'package:code_icons/presentation/ships/widgets/selectShip.dart';
import 'package:code_icons/presentation/utils/loading_state_animation.dart';
import 'package:code_icons/core/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddShipReport extends StatefulWidget {
  const AddShipReport({super.key});
  static String routeName = "AddShipReport";

  @override
  State<AddShipReport> createState() => _AddShipReportState();
}

class _AddShipReportState extends State<AddShipReport> {
  AddShipReportCubit addShipReportCubit = AddShipReportCubit();

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addShipReportCubit.getAllVesselsData();
    ControllerManager().vesselNotesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addShipReportCubit,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 16.0.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocConsumer<AddShipReportCubit, AddShipReportState>(
          listener: (context, state) {
            if (state is GetAllShipsSuccess) {
              /*     addShipReportCubit.customerData = state.customerData!;
              addShipReportCubit.receipts = state.receipts ?? []; */
            } else if (state is GetAllShipsError) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                showConfirmBtn: false,
                title: state.errorMsg,
                titleColor: AppColors.redColor,
              );
            }
          },
          builder: (context, state) {
            if (state is GetAllShipsLoading) {
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
                BlocConsumer<AddShipReportCubit, AddShipReportState>(
                  listener: (context, state) {
                    /*   if (state is GetAllCustomerDataSuccess) {
                      addCollectionCubit.skip += addCollectionCubit.take;
                      addCollectionCubit.customerData =
                          List.from(addCollectionCubit.customerData)
                            ..addAll(state.customerData!);
                      addCollectionCubit.hasMoreData =
                          state.customerData!.length == addCollectionCubit.take;
                      addCollectionCubit.isLoading = false;
                    } else if (state is GetAllCustomerDataError) {
                      addCollectionCubit.isLoading = false;
                      addCollectionCubit.hasMoreData = false;

                      // Optionally, show an error message here
                    } */
                  },
                  //get the payment reciet
                  bloc: addShipReportCubit,

                  builder: (context, state) {
                    return Column(
                      children: [
                        SelectShipEntity(
                          /*  initialItem: addShipReportCubit.ships.first, */
                          itemList: addShipReportCubit.ships,
                          title: "السفينه",
                          /*  hintText: "اسم التاجر", */
                          /*  headerFontSize: 25.sp, */
                          onChanged: (value) {
                            addShipReportCubit.selectShip(value);
                            context.read<AddShipReportCubit>().selectedShip =
                                value;
                            /*  context
                                .read<AddShipReportCubit>()
                                .fetchCustomerDataByID(
                                    customerId: context
                                        .read<AddShipReportCubit>()
                                        .selectedCustomer
                                        .idBl
                                        .toString()); */
                          },
                        ),
                      ],
                    );
                  },
                ),
                BlocConsumer<AddShipReportCubit, AddShipReportState>(
                  bloc: addShipReportCubit
                  /*    ..initialize(
                        controller: 'addCollectionPaymentReceitController') */
                  ,
                  listener: (context, state) {
                    // Add debug print
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        ReportDetails(
                          addShipReportCubit: addShipReportCubit,
                        ),
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
