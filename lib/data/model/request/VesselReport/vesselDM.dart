import 'dart:io';

class VesselReportDM {
  String vesselId;
  String notes;
  File? image; // The image file is stored here

  VesselReportDM({
    required this.vesselId,
    required this.notes,
    this.image,
  });

  // Convert only text fields to a map for the multipart request
  Map<String, String> toJson() {
    return {
      'vessel_id': vesselId,
      'notes': notes,
    };
  }
}
