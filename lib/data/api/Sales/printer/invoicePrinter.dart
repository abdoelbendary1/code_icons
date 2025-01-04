import 'dart:convert';
import 'dart:io';
import 'dart:typed_data'; // For handling binary data (image)
import 'package:http/http.dart' as http; // For making HTTP requests
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:code_icons/core/helpers/HttpRequestHelper.dart';
import 'package:code_icons/core/helpers/_handleResponseHelper.dart';
import 'package:code_icons/core/helpers/check_connection.dart';
import 'package:code_icons/data/api/auth/auth_manager_interface.dart';
import 'package:code_icons/domain/entities/failures/failures.dart';
// Your auth manager
import 'package:path_provider/path_provider.dart'; // For Image and FadeInImage widget

class invoicePrinterManager {
  final HttpRequestHelper httpRequestHelper;
  final HandleResponseHelper handleResponseHelper;
  final AuthManagerInterface authManager;

  invoicePrinterManager({
    required this.httpRequestHelper,
    required this.handleResponseHelper,
    required this.authManager,
  });

  /* Future<Either<Failures, Uint8List>> getImageFromAPI(
      {required String id}) async {
    try {
      // Check for network connectivity
      if (!await isConnected()) {
        return left(NetworkError(errorMessege: "تأكد من اتصالك بالانترنت"));
      }

      // Create the URL for the image request
      var url = Uri.parse(
          'https://amcc-api.code-icons.com/api/PrintReport/SalesInvoice/$id');

      // Get the token from the authManager
      var user = await authManager.getUser();
      var token = user?.accessToken;

      // Create an HTTP request with authorization headers
      var request = http.Request('GET', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Send the request and receive a streamed response
      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        // Read the byte stream and convert it to a Uint8List
        final imageBytes = await streamedResponse.stream.toBytes();

        // Return the image as Uint8List
        return right(imageBytes);
      } else {
        // Return the error message if status code is not 200
        return left(Failures(
            errorMessege: streamedResponse.reasonPhrase ?? "Unknown Error"));
      }
    } catch (e) {
      // Handle any errors and return them as Failures
      return left(Failures(errorMessege: e.toString()));
    }
  } */

  Future<http.Response> apiCall(
      {required String id, required Uri url, required String token}) async {
    String token = 'Your-Token-Here'; // Replace with your token logic.

    final headers = {
      "Authorization": "Bearer $token",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    };

    // Make the API call
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<File?> saveFile(Uint8List bytes, String extension) async {
    // Get the appropriate storage directory based on platform
    final Directory? appDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    if (appDir == null) return null;

    String tempPath = appDir.path;
    final String fileName =
        DateTime.now().microsecondsSinceEpoch.toString() + extension;

    // Create a new file and write the bytes
    File file = File('$tempPath/$fileName');
    await file.create();
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> openFile(String filePath) async {
    /*   final OpenResult result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      // Handle error if the file couldn't be opened
      print("Error opening file: ${result.message}");
    } */
  }
}

// Helper function to convert a byte stream to Uint8List
extension StreamToBytesExtension on http.ByteStream {
  Future<Uint8List> toBytes() async {
    final buffer = await this.toBytes();
    return Uint8List.fromList(buffer);
  }
}
