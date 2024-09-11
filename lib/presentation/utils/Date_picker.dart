import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePicker {
  static Future<void> selectDate({
    required BuildContext context,
    required TextEditingController controller,
    required Map<String, String> dateStorageMap,
    required String key,
    DateTime? lastDate,
    DateTime? firstDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      /* locale: Locale("ar"), */
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
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
