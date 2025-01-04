import 'package:code_icons/data/model/request/VesselReport/vesselDM.dart';
import 'package:code_icons/data/model/response/charterParty/vessel_dm.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/failures/failures.dart';

abstract class ICharterParty {
  Future<Either<Failures, String>> sendData(
      String vesselId, String notes, XFile? imageFile);
  Future<Either<Failures, List<VesselDm>>> getAllVesselsData();
}
