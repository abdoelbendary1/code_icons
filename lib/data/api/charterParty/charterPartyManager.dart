import 'dart:convert';
import 'dart:io';

import 'package:code_icons/data/api/api_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/data/api/charterParty/ICharterParty.dart';
import 'package:code_icons/data/model/request/VesselReport/vesselDM.dart';
import 'package:code_icons/data/model/response/charterParty/vessel_dm.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
import 'package:code_icons/services/di.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharterPartyManager implements ICharterParty {
  final AuthManagerInterface authManager = injectAuthManagerInterface();

  @override
  Future<Either<Failures, List<VesselDm>>> getAllVesselsData() async {
    try {
      // Check for connectivity
      if (!await isConnected()) {
        return left(NetworkError(
            errorMessege: "Please check your internet connection"));
      }

      // Construct the URL
      var url = Uri.https(ApiConstants.chamberApi, '/api/Vessel');

      // Obtain access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Send GET request
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Check if the response is a map or a list
        if (jsonResponse is List) {
          // Parse list of VesselDm objects
          List<VesselDm> vessels =
              jsonResponse.map((item) => VesselDm.fromJson(item)).toList();
          return right(vessels);
        } else if (jsonResponse is Map<String, dynamic>) {
          // If it's a map, wrap it in a list to match the return type
          VesselDm vessel = VesselDm.fromJson(jsonResponse);
          return right([vessel]);
        } else {
          return left(Failures(errorMessege: "Unexpected JSON format"));
        }
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        return left(Failures(
            errorMessege: 'Failed to fetch data: ${response.statusCode}'));
      }
    } catch (e) {
      print('Exception occurred: $e');
      return left(Failures(errorMessege: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> sendData(
      String vesselId, String notes, XFile? imageFile) async {
    try {
      // Check for connectivity
      if (!await isConnected()) {
        return left(NetworkError(
            errorMessege: "Please check your internet connection"));
      }

      // Obtain access token
      var user = await authManager.getUser();
      var token = user?.accessToken;

      if (token == null) {
        return left(
            Failures(errorMessege: "Failed to obtain authorization token"));
      }

      // Create Dio instance
      var dio = Dio();

      // Prepare headers
      var headers = {
        'Authorization': 'Bearer $token',
      };

      // Prepare form data
      var formData = FormData.fromMap({
        'vesselId': vesselId, // Ensure these match what the server expects
        'notes': notes,
      });

      // Attach image file if provided
      if (imageFile != null) {
        File image = File(imageFile.path);
        if (await image.exists()) {
          formData.files.add(
            MapEntry(
              'image', // This should match the server's expected field name for the file
              await MultipartFile.fromFile(
                image.path,
                filename: basename(image.path),
              ),
            ),
          );
        } else {
          return left(Failures(errorMessege: "Image file not found"));
        }
      }

      // Send POST request
      var response = await dio.post(
        'https://demoapi1.code-icons.com/api/VesselOperaiton/voyageReport',
        options: Options(
          headers: headers,
        ),
        data: formData,
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return right(response.data.toString());
      } else {
        return left(Failures(
            errorMessege:
                'Failed to upload: ${response.statusCode}, ${response.data}'));
      }
    } catch (e) {
      print('Exception occurred: $e');
      return left(Failures(errorMessege: e.toString()));
    }
  }
}
