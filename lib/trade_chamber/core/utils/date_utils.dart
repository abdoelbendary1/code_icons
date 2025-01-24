import 'package:intl/intl.dart';

String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('MMM d, y, h:mm:ss a');
      // Parse the input string into a DateTime object
      DateTime dateTime = inputFormat.parse(inputString);

      // Define the output format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      // Format the DateTime object into the desired output format
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    }
    return "";
  }