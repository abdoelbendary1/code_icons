import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class EmployeeEntity {
  @HiveField(0)
  String? idBl;
  @HiveField(1)
  String? codeBl;
  @HiveField(2)
  int? accountId;
  @HiveField(3)
  int? contractTypeBl;
  @HiveField(4)
  int? qualificationBl;
  @HiveField(5)
  String? qualificationNameBl;
  @HiveField(6)
  dynamic seaPassportNoBl;
  @HiveField(7)
  int? genderBl;
  @HiveField(8)
  int? maritalStatusBl;
  @HiveField(9)
  bool? isBussinestaxBl;
  @HiveField(10)
  bool? isInsuranceBl;
  @HiveField(11)
  String? startDateBl;
  @HiveField(12)
  String? insuranceDateBl;
  @HiveField(13)
  String? employeeNameBl;
  @HiveField(14)
  int? jobIdBl;
  @HiveField(15)
  String? jobNameBl;
  @HiveField(16)
  int? departmentIdBl;
  @HiveField(17)
  String? departmentNameBl;
  @HiveField(18)
  int? storeIdBl;
  @HiveField(19)
  String? storeNameBl;
  @HiveField(20)
  String? nationalIdBl;
  @HiveField(21)
  dynamic contractPeriodBl;
  @HiveField(22)
  dynamic insuranceNumBl;
  @HiveField(23)
  dynamic phoneNumBl;
  @HiveField(24)
  dynamic phoneWorkBl;
  @HiveField(25)
  dynamic phoneHomeBl;
  @HiveField(26)
  dynamic addressBl;
  @HiveField(27)
  dynamic partenarBl;
  @HiveField(28)
  dynamic phonePartenarBl;
  @HiveField(29)
  dynamic relationBl;
  @HiveField(30)
  int? salaryAccountBl;
  @HiveField(31)
  int? salaryBl;
  @HiveField(32)
  dynamic lastSalaryBl;
  @HiveField(33)
  int? nonTaxWageBl;
  @HiveField(34)
  int? addSalaryBl;
  @HiveField(35)
  int? totalSalaryBl;
  @HiveField(36)
  int? dayValueBl;
  @HiveField(37)
  int? hourlyValueBl;
  @HiveField(38)
  int? employeeTypeBl;
  @HiveField(39)
  int? commissionTypeBl;
  @HiveField(40)
  String? insertDate;
  @HiveField(41)
  dynamic commissionDisbursementTypeConstantBl;
  @HiveField(42)
  dynamic commissionDisbursementTypeSegmentsBl;
  @HiveField(43)
  dynamic eTicketBl;
  @HiveField(44)
  dynamic passNoBl;
  @HiveField(45)
  dynamic vesselIdBl;
  @HiveField(46)
  String? employeeNameEnBl;

  EmployeeEntity({
    this.idBl,
    this.codeBl,
    this.accountId,
    this.contractTypeBl,
    this.qualificationBl,
    this.qualificationNameBl,
    this.seaPassportNoBl,
    this.genderBl,
    this.maritalStatusBl,
    this.isBussinestaxBl,
    this.isInsuranceBl,
    this.startDateBl,
    this.insuranceDateBl,
    this.employeeNameBl,
    this.jobIdBl,
    this.jobNameBl,
    this.departmentIdBl,
    this.departmentNameBl,
    this.storeIdBl,
    this.storeNameBl,
    this.nationalIdBl,
    this.contractPeriodBl,
    this.insuranceNumBl,
    this.phoneNumBl,
    this.phoneWorkBl,
    this.phoneHomeBl,
    this.addressBl,
    this.partenarBl,
    this.phonePartenarBl,
    this.relationBl,
    this.salaryAccountBl,
    this.salaryBl,
    this.lastSalaryBl,
    this.nonTaxWageBl,
    this.addSalaryBl,
    this.totalSalaryBl,
    this.dayValueBl,
    this.hourlyValueBl,
    this.employeeTypeBl,
    this.commissionTypeBl,
    this.insertDate,
    this.commissionDisbursementTypeConstantBl,
    this.commissionDisbursementTypeSegmentsBl,
    this.eTicketBl,
    this.passNoBl,
    this.vesselIdBl,
    this.employeeNameEnBl,
  });
}
