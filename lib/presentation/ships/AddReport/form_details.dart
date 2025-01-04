import 'package:code_icons/data/model/request/VesselReport/vesselDM.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/utils/build_textfield.dart';
import 'package:code_icons/presentation/home/home_screen.dart';
import 'package:code_icons/presentation/ships/AddReport/cubit/add_ship_report_cubit.dart';
import 'package:code_icons/presentation/utils/Date_picker.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ReportDetails extends StatefulWidget {
  ReportDetails({super.key, required this.addShipReportCubit});
  AddShipReportCubit addShipReportCubit;
  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AddShipReportCubit, AddShipReportState>(
          bloc: widget.addShipReportCubit,
          builder: (context, state) {
            return BuildTextField(
              readOnly: true,
              label: "اختيار الصوره",
              /*   hint: "ملاحظات", */

              controller: widget.addShipReportCubit.fileNameController,
              /*      icon: Icons.local_activity, */
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "يجب ادخال ملاحظات";
                }
                return null;
              },
              onTap: () async {
                XFile? file =
                    await widget.addShipReportCubit.uploadFile(context);
                if (file != null) {
                  widget.addShipReportCubit.pickedFile = file;
                  widget.addShipReportCubit.fileName = file.name;
                  widget.addShipReportCubit.filePath = file.path;
                  widget.addShipReportCubit.checkfile = true;
                  widget.addShipReportCubit.setFileName();
                }
              },
            );
          },
        ),
        BuildTextField(
          label: "ملاحظات",
          /*   hint: "ملاحظات", */
          maxLines: 10,
          minLines: 3,
          controller: ControllerManager().vesselNotesController,
          /*      icon: Icons.local_activity, */
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "يجب ادخال ملاحظات";
            }
            return null;
          },
          onTap: () {
            ControllerManager().vesselNotesController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: ControllerManager()
                    .vesselNotesController
                    .value
                    .text
                    .length);
          },
        ),
        Row(
          children: [
            const Spacer(),
            BlocListener<AddShipReportCubit, AddShipReportState>(
              bloc: widget.addShipReportCubit,
              listener: (context, state) {
                if (state is AddReportSuccess) {
/*                   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
 */
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    showConfirmBtn: false,
                    confirmBtnText: "الذهاب الى الصفحه الرئيسيه",
                    title: "تمت الإضافه بنجاح",
                    titleColor: AppColors.lightBlueColor,
                    /*   onConfirmBtnTap: () {}, */
                  );
                } else if (state is AddReportError) {
                  QuickAlert.show(
                    animType: QuickAlertAnimType.slideInUp,
                    context: context,
                    type: QuickAlertType.error,
                    showConfirmBtn: false,
                    title: state.errorMsg,
                    titleColor: AppColors.redColor,
                  );
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
                  final selectedShip =
                      context.read<AddShipReportCubit>().selectedShip;
                  if (selectedShip.idBl != null) {
                    widget.addShipReportCubit.sendData(
                      selectedShip.idBl.toString(),
                      ControllerManager().vesselNotesController.text,
                    );
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Ship not selected",
                      titleColor: AppColors.redColor,
                    );
                  }
                },
                child: const Text("حفظ"),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
