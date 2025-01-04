class VesselDm {
  List<Vessels>? vessels;
  List<Voyages>? voyages;

  VesselDm({this.vessels, this.voyages});

  VesselDm.fromJson(Map<String, dynamic> json) {
    if (json["vessels"] is List) {
      vessels = json["vessels"] == null
          ? null
          : (json["vessels"] as List).map((e) => Vessels.fromJson(e)).toList();
    }
    if (json["voyages"] is List) {
      voyages = json["voyages"] == null
          ? null
          : (json["voyages"] as List).map((e) => Voyages.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (vessels != null) {
      _data["vessels"] = vessels?.map((e) => e.toJson()).toList();
    }
    if (voyages != null) {
      _data["voyages"] = voyages?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Voyages {
  int? idBl;
  String? voyageNumberBl;
  int? dischargePortIdBl;
  String? dischargePortNameBl;
  int? loadingPortIdBl;
  String? loadingPortNameBl;
  dynamic contractIdBl;
  String? arrivalDateBl;
  dynamic berthingDateBl;
  String? departDateBl;
  int? noOfBillsBl;
  int? voyageConditionBl;
  int? vesselIdBl;
  String? vesselNameBl;
  dynamic shiperIdBl;
  dynamic receiverIdBl;
  dynamic charterIdBl;
  dynamic notesBl;
  String? insertDate;
  int? voyagePreformaIdBl;

  Voyages(
      {this.idBl,
      this.voyageNumberBl,
      this.dischargePortIdBl,
      this.dischargePortNameBl,
      this.loadingPortIdBl,
      this.loadingPortNameBl,
      this.contractIdBl,
      this.arrivalDateBl,
      this.berthingDateBl,
      this.departDateBl,
      this.noOfBillsBl,
      this.voyageConditionBl,
      this.vesselIdBl,
      this.vesselNameBl,
      this.shiperIdBl,
      this.receiverIdBl,
      this.charterIdBl,
      this.notesBl,
      this.insertDate,
      this.voyagePreformaIdBl});

  Voyages.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["voyageNumberBL"] is String) {
      voyageNumberBl = json["voyageNumberBL"];
    }
    if (json["dischargePortIdBL"] is int) {
      dischargePortIdBl = json["dischargePortIdBL"];
    }
    if (json["dischargePortNameBL"] is String) {
      dischargePortNameBl = json["dischargePortNameBL"];
    }
    if (json["loadingPortIdBL"] is int) {
      loadingPortIdBl = json["loadingPortIdBL"];
    }
    if (json["loadingPortNameBL"] is String) {
      loadingPortNameBl = json["loadingPortNameBL"];
    }
    contractIdBl = json["contractIdBL"];
    if (json["arrivalDateBL"] is String) {
      arrivalDateBl = json["arrivalDateBL"];
    }
    berthingDateBl = json["berthingDateBL"];
    if (json["departDateBL"] is String) {
      departDateBl = json["departDateBL"];
    }
    if (json["noOfBillsBL"] is int) {
      noOfBillsBl = json["noOfBillsBL"];
    }
    if (json["voyageConditionBL"] is int) {
      voyageConditionBl = json["voyageConditionBL"];
    }
    if (json["vesselIdBL"] is int) {
      vesselIdBl = json["vesselIdBL"];
    }
    if (json["vesselNameBL"] is String) {
      vesselNameBl = json["vesselNameBL"];
    }
    shiperIdBl = json["shiperIdBL"];
    receiverIdBl = json["receiverIdBL"];
    charterIdBl = json["charterIdBL"];
    notesBl = json["notesBL"];
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    if (json["voyagePreformaIdBL"] is int) {
      voyagePreformaIdBl = json["voyagePreformaIdBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["voyageNumberBL"] = voyageNumberBl;
    _data["dischargePortIdBL"] = dischargePortIdBl;
    _data["dischargePortNameBL"] = dischargePortNameBl;
    _data["loadingPortIdBL"] = loadingPortIdBl;
    _data["loadingPortNameBL"] = loadingPortNameBl;
    _data["contractIdBL"] = contractIdBl;
    _data["arrivalDateBL"] = arrivalDateBl;
    _data["berthingDateBL"] = berthingDateBl;
    _data["departDateBL"] = departDateBl;
    _data["noOfBillsBL"] = noOfBillsBl;
    _data["voyageConditionBL"] = voyageConditionBl;
    _data["vesselIdBL"] = vesselIdBl;
    _data["vesselNameBL"] = vesselNameBl;
    _data["shiperIdBL"] = shiperIdBl;
    _data["receiverIdBL"] = receiverIdBl;
    _data["charterIdBL"] = charterIdBl;
    _data["notesBL"] = notesBl;
    _data["insertDate"] = insertDate;
    _data["voyagePreformaIdBL"] = voyagePreformaIdBl;
    return _data;
  }
}

class Vessels {
  int? idBl;
  String? vesselNameBl;
  FlagBl? flagBl;
  dynamic vesselLoadBl;
  dynamic vesselTypeBl;
  String? callSignBl;
  String? iMobl;
  dynamic mMsibl;
  int? lengthOabl;
  dynamic lengthBpbl;
  dynamic breadthBl;
  int? grossTonnageBl;
  int? nrtBl;
  int? deadWeightBl;
  int? ownerIdBl;
  String? ownerNameBl;
  dynamic builtBl;
  dynamic placeofBuiltBl;
  dynamic dateConvertedBl;
  dynamic homePortBl;
  dynamic officialNoBl;
  dynamic depthBl;
  dynamic suezGtbl;
  dynamic suezNtbl;
  bool? isOwnedBl;
  String? insertDate;
  dynamic voyages;

  Vessels(
      {this.idBl,
      this.vesselNameBl,
      this.flagBl,
      this.vesselLoadBl,
      this.vesselTypeBl,
      this.callSignBl,
      this.iMobl,
      this.mMsibl,
      this.lengthOabl,
      this.lengthBpbl,
      this.breadthBl,
      this.grossTonnageBl,
      this.nrtBl,
      this.deadWeightBl,
      this.ownerIdBl,
      this.ownerNameBl,
      this.builtBl,
      this.placeofBuiltBl,
      this.dateConvertedBl,
      this.homePortBl,
      this.officialNoBl,
      this.depthBl,
      this.suezGtbl,
      this.suezNtbl,
      this.isOwnedBl,
      this.insertDate,
      this.voyages});

  Vessels.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is int) {
      idBl = json["idBL"];
    }
    if (json["vesselNameBL"] is String) {
      vesselNameBl = json["vesselNameBL"];
    }
    if (json["flagBL"] is Map) {
      flagBl = json["flagBL"] == null ? null : FlagBl.fromJson(json["flagBL"]);
    }
    vesselLoadBl = json["vesselLoadBL"];
    vesselTypeBl = json["vesselTypeBL"];
    if (json["callSignBL"] is String) {
      callSignBl = json["callSignBL"];
    }
    if (json["iMOBL"] is String) {
      iMobl = json["iMOBL"];
    }
    mMsibl = json["mMSIBL"];
    if (json["lengthOABL"] is int) {
      lengthOabl = json["lengthOABL"];
    }
    lengthBpbl = json["lengthBPBL"];
    breadthBl = json["breadthBL"];
    if (json["grossTonnageBL"] is int) {
      grossTonnageBl = json["grossTonnageBL"];
    }
    if (json["nrtBL"] is int) {
      nrtBl = json["nrtBL"];
    }
    if (json["deadWeightBL"] is int) {
      deadWeightBl = json["deadWeightBL"];
    }
    if (json["ownerIdBL"] is int) {
      ownerIdBl = json["ownerIdBL"];
    }
    if (json["ownerNameBL"] is String) {
      ownerNameBl = json["ownerNameBL"];
    }
    builtBl = json["builtBL"];
    placeofBuiltBl = json["placeofBuiltBL"];
    dateConvertedBl = json["dateConvertedBL"];
    homePortBl = json["homePortBL"];
    officialNoBl = json["officialNoBL"];
    depthBl = json["depthBL"];
    suezGtbl = json["suezGTBL"];
    suezNtbl = json["suezNTBL"];
    if (json["isOwnedBL"] is bool) {
      isOwnedBl = json["isOwnedBL"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    voyages = json["voyages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["vesselNameBL"] = vesselNameBl;
    if (flagBl != null) {
      _data["flagBL"] = flagBl?.toJson();
    }
    _data["vesselLoadBL"] = vesselLoadBl;
    _data["vesselTypeBL"] = vesselTypeBl;
    _data["callSignBL"] = callSignBl;
    _data["iMOBL"] = iMobl;
    _data["mMSIBL"] = mMsibl;
    _data["lengthOABL"] = lengthOabl;
    _data["lengthBPBL"] = lengthBpbl;
    _data["breadthBL"] = breadthBl;
    _data["grossTonnageBL"] = grossTonnageBl;
    _data["nrtBL"] = nrtBl;
    _data["deadWeightBL"] = deadWeightBl;
    _data["ownerIdBL"] = ownerIdBl;
    _data["ownerNameBL"] = ownerNameBl;
    _data["builtBL"] = builtBl;
    _data["placeofBuiltBL"] = placeofBuiltBl;
    _data["dateConvertedBL"] = dateConvertedBl;
    _data["homePortBL"] = homePortBl;
    _data["officialNoBL"] = officialNoBl;
    _data["depthBL"] = depthBl;
    _data["suezGTBL"] = suezGtbl;
    _data["suezNTBL"] = suezNtbl;
    _data["isOwnedBL"] = isOwnedBl;
    _data["insertDate"] = insertDate;
    _data["voyages"] = voyages;
    return _data;
  }
}

class FlagBl {
  int? id;
  String? name;
  String? alpha2Code;
  String? alpha3Code;
  String? numericCode;
  String? callingCode;

  FlagBl(
      {this.id,
      this.name,
      this.alpha2Code,
      this.alpha3Code,
      this.numericCode,
      this.callingCode});

  FlagBl.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["alpha2Code"] is String) {
      alpha2Code = json["alpha2Code"];
    }
    if (json["alpha3Code"] is String) {
      alpha3Code = json["alpha3Code"];
    }
    if (json["numericCode"] is String) {
      numericCode = json["numericCode"];
    }
    if (json["callingCode"] is String) {
      callingCode = json["callingCode"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["alpha2Code"] = alpha2Code;
    _data["alpha3Code"] = alpha3Code;
    _data["numericCode"] = numericCode;
    _data["callingCode"] = callingCode;
    return _data;
  }
}
