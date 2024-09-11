import 'package:hive/hive.dart';
import "package:code_icons/domain/entities/HR/employee/employee_entity.dart";


class EmployeeEntityAdapter extends TypeAdapter<EmployeeEntity> {
  @override
  final int typeId = 4; // Ensure this is unique and different from other adapters

  @override
  EmployeeEntity read(BinaryReader reader) {
    return EmployeeEntity(
      idBl: reader.readString(),
      codeBl: reader.readString(),
      accountId: reader.readInt(),
      contractTypeBl: reader.readInt(),
      qualificationBl: reader.readInt(),
      qualificationNameBl: reader.readString(),
      seaPassportNoBl: reader.read(),
      genderBl: reader.readInt(),
      maritalStatusBl: reader.readInt(),
      isBussinestaxBl: reader.readBool(),
      isInsuranceBl: reader.readBool(),
      startDateBl: reader.readString(),
      insuranceDateBl: reader.readString(),
      employeeNameBl: reader.readString(),
      jobIdBl: reader.readInt(),
      jobNameBl: reader.readString(),
      departmentIdBl: reader.readInt(),
      departmentNameBl: reader.readString(),
      storeIdBl: reader.readInt(),
      storeNameBl: reader.readString(),
      nationalIdBl: reader.readString(),
      contractPeriodBl: reader.read(),
      insuranceNumBl: reader.read(),
      phoneNumBl: reader.read(),
      phoneWorkBl: reader.read(),
      phoneHomeBl: reader.read(),
      addressBl: reader.read(),
      partenarBl: reader.read(),
      phonePartenarBl: reader.read(),
      relationBl: reader.read(),
      salaryAccountBl: reader.readInt(),
      salaryBl: reader.readInt(),
      lastSalaryBl: reader.read(),
      nonTaxWageBl: reader.readInt(),
      addSalaryBl: reader.readInt(),
      totalSalaryBl: reader.readInt(),
      dayValueBl: reader.readInt(),
      hourlyValueBl: reader.readInt(),
      employeeTypeBl: reader.readInt(),
      commissionTypeBl: reader.readInt(),
      insertDate: reader.readString(),
      commissionDisbursementTypeConstantBl: reader.read(),
      commissionDisbursementTypeSegmentsBl: reader.read(),
      eTicketBl: reader.read(),
      passNoBl: reader.read(),
      vesselIdBl: reader.read(),
      employeeNameEnBl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeEntity obj) {
    writer.writeString(obj.idBl ?? '');
    writer.writeString(obj.codeBl ?? '');
    writer.writeInt(obj.accountId ?? 0);
    writer.writeInt(obj.contractTypeBl ?? 0);
    writer.writeInt(obj.qualificationBl ?? 0);
    writer.writeString(obj.qualificationNameBl ?? '');
    writer.write(obj.seaPassportNoBl);
    writer.writeInt(obj.genderBl ?? 0);
    writer.writeInt(obj.maritalStatusBl ?? 0);
    writer.writeBool(obj.isBussinestaxBl ?? false);
    writer.writeBool(obj.isInsuranceBl ?? false);
    writer.writeString(obj.startDateBl ?? '');
    writer.writeString(obj.insuranceDateBl ?? '');
    writer.writeString(obj.employeeNameBl ?? '');
    writer.writeInt(obj.jobIdBl ?? 0);
    writer.writeString(obj.jobNameBl ?? '');
    writer.writeInt(obj.departmentIdBl ?? 0);
    writer.writeString(obj.departmentNameBl ?? '');
    writer.writeInt(obj.storeIdBl ?? 0);
    writer.writeString(obj.storeNameBl ?? '');
    writer.writeString(obj.nationalIdBl ?? '');
    writer.write(obj.contractPeriodBl);
    writer.write(obj.insuranceNumBl);
    writer.write(obj.phoneNumBl);
    writer.write(obj.phoneWorkBl);
    writer.write(obj.phoneHomeBl);
    writer.write(obj.addressBl);
    writer.write(obj.partenarBl);
    writer.write(obj.phonePartenarBl);
    writer.write(obj.relationBl);
    writer.writeInt(obj.salaryAccountBl ?? 0);
    writer.writeInt(obj.salaryBl ?? 0);
    writer.write(obj.lastSalaryBl);
    writer.writeInt(obj.nonTaxWageBl ?? 0);
    writer.writeInt(obj.addSalaryBl ?? 0);
    writer.writeInt(obj.totalSalaryBl ?? 0);
    writer.writeInt(obj.dayValueBl ?? 0);
    writer.writeInt(obj.hourlyValueBl ?? 0);
    writer.writeInt(obj.employeeTypeBl ?? 0);
    writer.writeInt(obj.commissionTypeBl ?? 0);
    writer.writeString(obj.insertDate ?? '');
    writer.write(obj.commissionDisbursementTypeConstantBl);
    writer.write(obj.commissionDisbursementTypeSegmentsBl);
    writer.write(obj.eTicketBl);
    writer.write(obj.passNoBl);
    writer.write(obj.vesselIdBl);
    writer.writeString(obj.employeeNameEnBl ?? '');
  }
}
