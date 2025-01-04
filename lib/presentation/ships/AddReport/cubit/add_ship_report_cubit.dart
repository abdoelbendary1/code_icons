import 'package:code_icons/data/api/charterParty/charterPartyManager.dart';

import 'package:bloc/bloc.dart';
import 'package:code_icons/data/model/request/VesselReport/vesselDM.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/response/charterParty/vessel_dm.dart';

part 'add_ship_report_state.dart';

class AddShipReportCubit extends Cubit<AddShipReportState> {
  AddShipReportCubit() : super(AddShipReportInitial());
  XFile? pickedFile;
  String fileName = '';
  String filePath = '';
  bool checkfile = false;
  TextEditingController fileNameController = TextEditingController();
  Map<String, String> dateStorageMap = {
    'UnlimitedPaymentReceitDateController': '',
  };
  List<Vessels> ships = [];
  CharterPartyManager charterPartyManager = CharterPartyManager();
  late Vessels selectedShip = Vessels();
  Future<XFile?> uploadFile(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return null;
    }
  }

  void sendData(
    String vesselId,
    String notes,
    /* XFile? imageFile */
  ) async {
    emit(AddReportLoading());
    var either =
        await charterPartyManager.sendData(vesselId, notes, pickedFile);
    either.fold((l) => emit(AddReportError(errorMsg: l.errorMessege)),
        (r) => emit(AddReportSuccess()));
  }

  void selectShip(Vessels ship) {
    selectedShip = ship;
    emit(SelectShip(ship: ship));
  }

  void getAllVesselsData() async {
    emit(GetAllShipsLoading());
    var either = await charterPartyManager.getAllVesselsData();
    either.fold((l) => emit(GetAllShipsError(errorMsg: l.errorMessege)), (r) {
      for (var vesselDm in r) {
        if (vesselDm.vessels != null) {
          ships.addAll(vesselDm.vessels!);
        }
      }
      emit(GetAllShipsSuccess(ships: r));
    });
  }

  void setFileName() {
    fileNameController.text = fileName;
  }

  /*  Future<Either<Failures, String>> sendData(
      VesselReportDM vesselReport, XFile? imageFile) async {
    try {
      // Check for connectivity
      if (!await isConnected()) {
        return left(NetworkError(
            errorMessege: "Please check your internet connection"));
      }

      // Create URI, replace with actual server URL if needed
      final uri = Uri.https(
          ApiConstants.chamberApi, '/api/VesselOperaiton/voyageReport');

      // Obtain access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      if (token == null) {
        return left(
            Failures(errorMessege: "Failed to obtain authorization token"));
      }

      // Initialize multipart request
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Convert and add form data fields from the vesselReport
      vesselReport.toJson().forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Attach image file if provided
      if (imageFile != null) {
        File image = File(imageFile.path);
        if (await image.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'file', // Change 'file' to match the server's expected field name
            image.path,
            filename: basename(image.path),
          ));
        } else {
          return left(Failures(errorMessege: "Image file not found"));
        }
      }

      // Send the request and handle response
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return right(responseBody.body);
      } else {
        print('Error ${response.statusCode}: ${responseBody.body}');
        return left(Failures(
            errorMessege:
                'Failed to upload: ${response.statusCode}, ${responseBody.body}'));
      }
    } catch (e) {
      print('Exception occurred: $e');
      return left(Failures(errorMessege: e.toString()));
    }
  }
 */
  /*  Future<Either<Failures, String>> sendData(
      VesselReportDM vesselReport, XFile? imageFile) async {
    try {
      // Check for connectivity (replace this with your own check)
      if (!await isConnected()) {
        return left(NetworkError(
            errorMessege: "Please check your internet connection"));
      }

      final uri =
          Uri.https(ApiConstants.baseUrl, '/api/VesselOperaiton/voyageReport');
      var user = await authManager.getUser();
      var token = user?.accessToken;

      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Add text fields from the model
      request.fields.addAll(vesselReport.toJson());

      // Add the image file to the request if it exists
      if (imageFile != null) {
        File image = File(imageFile.path); // Convert XFile to File
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          filename: basename(image.path),
        ));
      } else {
        print('No image file provided');
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return right(response.body);
      } else {
        return left(
            Failures(errorMessege: 'Failed to upload: ${response.statusCode}'));
      }
    } catch (e) {
      return left(Failures(errorMessege: e.toString()));
    }
  }
 */
}
