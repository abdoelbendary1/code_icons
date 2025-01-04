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
    // Show the date picker dialog
    DateTime? pickedDate = await showDatePicker(
      context: context,
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
      // Get the current time
      final now = DateTime.now();

      // Combine the picked date with the current time
      final bookedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      );

      // Store the combined date in ISO8601 format
      String storedDate = bookedDate.toIso8601String();

      // Format the combined date for display
      String displayDate = DateFormat('MMM d, y, h:mm:ss a').format(bookedDate);
      controller.text = displayDate;

      // Store the combined date in the map based on the key
      dateStorageMap[key] = storedDate;
    }
  }
}
