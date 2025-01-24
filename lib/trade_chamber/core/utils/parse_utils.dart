double? parseDouble(String input) {
  return input.isNotEmpty ? double.tryParse(input) : null;
}

int? parseInt(String input) {
  return input.isNotEmpty ? int.tryParse(input) : null;
}
