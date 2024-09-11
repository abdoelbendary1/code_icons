import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:hive/hive.dart';

class CustomerDataEntityAdapter extends TypeAdapter<CustomerDataEntity> {
  @override
  final int typeId =
      2; // Ensure this is unique and different from other adapters

  @override
  CustomerDataEntity read(BinaryReader reader) {
    return CustomerDataEntity(
      idBl: reader.readInt(),
      brandNameBl: reader.readString(),
      nationalIdBl: reader.readString(),
      birthDayBl: reader.readString(),
      tradeRegistryBl: reader.readString(),
      licenseDateBl: reader.readString(),
      licenseYearBl: reader.readInt(),
      capitalBl: reader.readDouble(),
      validBl: reader.readInt(),
      companyTypeBl: reader.readInt(),
      companyTypeNameBl: reader.readString(),
      currencyIdBl: reader.readInt(),
      tradeOfficeBl: reader.readInt(),
      tradeOfficeNameBl: reader.readString(),
      activityBl: reader.readInt(),
      activityNameBl: reader.readString(),
      expiredBl: reader.read(), // Assuming dynamic, this needs special care
      divisionBl: reader.readString(),
      tradeTypeBl: reader.readString(),
      ownerBl: reader.readString(),
      addressBl: reader.readString(),
      stationBl: reader.readInt(),
      stationNameBl: reader.readString(),
      phoneBl: reader.readString(),
      numExpiredBl: reader.read(), // Assuming dynamic, this needs special care
      tradeRegistryTypeBl: reader.readInt(),
      customerDataIdBl: reader.readInt(),
      message: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomerDataEntity obj) {
    writer.writeInt(obj.idBl ?? 0);
    writer.writeString(obj.brandNameBl ?? '');
    writer.writeString(obj.nationalIdBl ?? '');
    writer.writeString(obj.birthDayBl ?? '');
    writer.writeString(obj.tradeRegistryBl ?? '');
    writer.writeString(obj.licenseDateBl ?? '');
    writer.writeInt(obj.licenseYearBl ?? 0);
    writer.writeDouble(obj.capitalBl ?? 0.0);
    writer.writeInt(obj.validBl ?? 0);
    writer.writeInt(obj.companyTypeBl ?? 0);
    writer.writeString(obj.companyTypeNameBl ?? '');
    writer.writeInt(obj.currencyIdBl ?? 0);
    writer.writeInt(obj.tradeOfficeBl ?? 0);
    writer.writeString(obj.tradeOfficeNameBl ?? '');
    writer.writeInt(obj.activityBl ?? 0);
    writer.writeString(obj.activityNameBl ?? '');
    writer.write(obj.expiredBl); // Assuming dynamic, stored as is
    writer.writeString(obj.divisionBl ?? '');
    writer.writeString(obj.tradeTypeBl ?? '');
    writer.writeString(obj.ownerBl ?? '');
    writer.writeString(obj.addressBl ?? '');
    writer.writeInt(obj.stationBl ?? 0);
    writer.writeString(obj.stationNameBl ?? '');
    writer.writeString(obj.phoneBl ?? '');
    writer.write(obj.numExpiredBl); // Assuming dynamic, stored as is
    writer.writeInt(obj.tradeRegistryTypeBl ?? 0);
    writer.writeInt(obj.customerDataIdBl ?? 0);
    writer.writeString(obj.message ?? '');
  }
}
