import 'package:code_icons/domain/entities/HR/employee/employee_entity.dart';

class EmployeeDataModel extends EmployeeEntity {
  EmployeeDataModel({
    super.idBl,
    super.codeBl,
    super.accountId,
    super.contractTypeBl,
    super.qualificationBl,
    super.qualificationNameBl,
    super.seaPassportNoBl,
    super.genderBl,
    super.maritalStatusBl,
    super.isBussinestaxBl,
    super.isInsuranceBl,
    super.startDateBl,
    super.insuranceDateBl,
    super.employeeNameBl,
    super.jobIdBl,
    super.jobNameBl,
    super.departmentIdBl,
    super.departmentNameBl,
    super.storeIdBl,
    super.storeNameBl,
    super.nationalIdBl,
    super.contractPeriodBl,
    super.insuranceNumBl,
    super.phoneNumBl,
    super.phoneWorkBl,
    super.phoneHomeBl,
    super.addressBl,
    super.partenarBl,
    super.phonePartenarBl,
    super.relationBl,
    super.salaryAccountBl,
    super.salaryBl,
    super.lastSalaryBl,
    super.nonTaxWageBl,
    super.addSalaryBl,
    super.totalSalaryBl,
    super.dayValueBl,
    super.hourlyValueBl,
    super.employeeTypeBl,
    super.commissionTypeBl,
    super.insertDate,
    super.commissionDisbursementTypeConstantBl,
    super.commissionDisbursementTypeSegmentsBl,
    super.eTicketBl,
    super.passNoBl,
    super.vesselIdBl,
    super.employeeNameEnBl,
  });

  EmployeeDataModel.fromJson(Map<String, dynamic> json) {
    if (json["idBL"] is String) {
      idBl = json["idBL"];
    }
    if (json["codeBL"] is String) {
      codeBl = json["codeBL"];
    }
    if (json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if (json["contractTypeBL"] is int) {
      contractTypeBl = json["contractTypeBL"];
    }
    if (json["qualificationBL"] is int) {
      qualificationBl = json["qualificationBL"];
    }
    if (json["qualificationNameBL"] is String) {
      qualificationNameBl = json["qualificationNameBL"];
    }
    seaPassportNoBl = json["seaPassportNoBL"];
    if (json["genderBL"] is int) {
      genderBl = json["genderBL"];
    }
    if (json["maritalStatusBL"] is int) {
      maritalStatusBl = json["maritalStatusBL"];
    }
    if (json["isBussinestaxBL"] is bool) {
      isBussinestaxBl = json["isBussinestaxBL"];
    }
    if (json["isInsuranceBL"] is bool) {
      isInsuranceBl = json["isInsuranceBL"];
    }
    if (json["startDateBL"] is String) {
      startDateBl = json["startDateBL"];
    }
    if (json["insuranceDateBL"] is String) {
      insuranceDateBl = json["insuranceDateBL"];
    }
    if (json["employeeNameBL"] is String) {
      employeeNameBl = json["employeeNameBL"];
    }
    if (json["jobIdBL"] is int) {
      jobIdBl = json["jobIdBL"];
    }
    if (json["jobNameBL"] is String) {
      jobNameBl = json["jobNameBL"];
    }
    if (json["departmentIdBL"] is int) {
      departmentIdBl = json["departmentIdBL"];
    }
    if (json["departmentNameBL"] is String) {
      departmentNameBl = json["departmentNameBL"];
    }
    if (json["storeIdBL"] is int) {
      storeIdBl = json["storeIdBL"];
    }
    if (json["storeNameBL"] is String) {
      storeNameBl = json["storeNameBL"];
    }
    if (json["nationalIdBL"] is String) {
      nationalIdBl = json["nationalIdBL"];
    }
    contractPeriodBl = json["contractPeriodBL"];
    insuranceNumBl = json["insuranceNumBL"];
    phoneNumBl = json["phoneNumBL"];
    phoneWorkBl = json["phoneWorkBL"];
    phoneHomeBl = json["phoneHomeBL"];
    addressBl = json["addressBL"];
    partenarBl = json["partenarBL"];
    phonePartenarBl = json["phonePartenarBL"];
    relationBl = json["relationBL"];
    if (json["salaryAccountBL"] is int) {
      salaryAccountBl = json["salaryAccountBL"];
    }
    if (json["salaryBL"] is int) {
      salaryBl = json["salaryBL"];
    }
    lastSalaryBl = json["lastSalaryBL"];
    if (json["nonTaxWageBL"] is int) {
      nonTaxWageBl = json["nonTaxWageBL"];
    }
    if (json["addSalaryBL"] is int) {
      addSalaryBl = json["addSalaryBL"];
    }
    if (json["totalSalaryBL"] is int) {
      totalSalaryBl = json["totalSalaryBL"];
    }
    if (json["dayValueBL"] is int) {
      dayValueBl = json["dayValueBL"];
    }
    if (json["hourlyValueBL"] is int) {
      hourlyValueBl = json["hourlyValueBL"];
    }
    if (json["employeeTypeBL"] is int) {
      employeeTypeBl = json["employeeTypeBL"];
    }
    if (json["commissionTypeBL"] is int) {
      commissionTypeBl = json["commissionTypeBL"];
    }
    if (json["insertDate"] is String) {
      insertDate = json["insertDate"];
    }
    commissionDisbursementTypeConstantBl =
        json["commissionDisbursementTypeConstantBL"];
    commissionDisbursementTypeSegmentsBl =
        json["commissionDisbursementTypeSegmentsBL"];
    eTicketBl = json["eTicketBL"];
    passNoBl = json["passNoBL"];
    vesselIdBl = json["vesselIdBL"];
    if (json["employeeNameEnBL"] is String) {
      employeeNameEnBl = json["employeeNameEnBL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idBL"] = idBl;
    _data["codeBL"] = codeBl;
    _data["accountId"] = accountId;
    _data["contractTypeBL"] = contractTypeBl;
    _data["qualificationBL"] = qualificationBl;
    _data["qualificationNameBL"] = qualificationNameBl;
    _data["seaPassportNoBL"] = seaPassportNoBl;
    _data["genderBL"] = genderBl;
    _data["maritalStatusBL"] = maritalStatusBl;
    _data["isBussinestaxBL"] = isBussinestaxBl;
    _data["isInsuranceBL"] = isInsuranceBl;
    _data["startDateBL"] = startDateBl;
    _data["insuranceDateBL"] = insuranceDateBl;
    _data["employeeNameBL"] = employeeNameBl;
    _data["jobIdBL"] = jobIdBl;
    _data["jobNameBL"] = jobNameBl;
    _data["departmentIdBL"] = departmentIdBl;
    _data["departmentNameBL"] = departmentNameBl;
    _data["storeIdBL"] = storeIdBl;
    _data["storeNameBL"] = storeNameBl;
    _data["nationalIdBL"] = nationalIdBl;
    _data["contractPeriodBL"] = contractPeriodBl;
    _data["insuranceNumBL"] = insuranceNumBl;
    _data["phoneNumBL"] = phoneNumBl;
    _data["phoneWorkBL"] = phoneWorkBl;
    _data["phoneHomeBL"] = phoneHomeBl;
    _data["addressBL"] = addressBl;
    _data["partenarBL"] = partenarBl;
    _data["phonePartenarBL"] = phonePartenarBl;
    _data["relationBL"] = relationBl;
    _data["salaryAccountBL"] = salaryAccountBl;
    _data["salaryBL"] = salaryBl;
    _data["lastSalaryBL"] = lastSalaryBl;
    _data["nonTaxWageBL"] = nonTaxWageBl;
    _data["addSalaryBL"] = addSalaryBl;
    _data["totalSalaryBL"] = totalSalaryBl;
    _data["dayValueBL"] = dayValueBl;
    _data["hourlyValueBL"] = hourlyValueBl;
    _data["employeeTypeBL"] = employeeTypeBl;
    _data["commissionTypeBL"] = commissionTypeBl;
    _data["insertDate"] = insertDate;
    _data["commissionDisbursementTypeConstantBL"] =
        commissionDisbursementTypeConstantBl;
    _data["commissionDisbursementTypeSegmentsBL"] =
        commissionDisbursementTypeSegmentsBl;
    _data["eTicketBL"] = eTicketBl;
    _data["passNoBL"] = passNoBl;
    _data["vesselIdBL"] = vesselIdBl;
    _data["employeeNameEnBL"] = employeeNameEnBl;
    return _data;
  }
}
