import 'package:code_icons/domain/entities/settings/settings_entity.dart';
import 'package:hive/hive.dart';

class SettingsEntityAdapter extends TypeAdapter<SettingsEntity> {
  @override
  final int typeId =
      3; // Ensure this is unique and different from other adapters

  @override
  SettingsEntity read(BinaryReader reader) {
    return SettingsEntity(
        collections: reader.readString(),
        finance: reader.readString(),
        cashInOut: reader.readString(),
        purchases: reader.readString(),
        sales: reader.readString(),
        costructions: reader.readString(),
        charterparty: reader.readString(),
        humanResources: reader.readString(),
        stores: reader.readString(),
        reports: reader.readString(),
        realStateInvestments: reader.readString(),
        imports: reader.readString(),
        hospital: reader.readString(),
        settings: reader.readString());
  }

  @override
  void write(BinaryWriter writer, SettingsEntity obj) {
    writer.writeString(obj.collections ?? '');
    writer.writeString(obj.finance ?? '');
    writer.writeString(obj.cashInOut ?? '');
    writer.writeString(obj.purchases ?? '');
    writer.writeString(obj.sales ?? '');
    writer.writeString(obj.costructions ?? '');
    writer.writeString(obj.charterparty ?? '');
    writer.writeString(obj.humanResources ?? '');
    writer.writeString(obj.stores ?? '');
    writer.writeString(obj.reports ?? '');
    writer.writeString(obj.realStateInvestments ?? '');
    writer.writeString(obj.imports ?? '');
    writer.writeString(obj.hospital ?? '');
    writer.writeString(obj.settings ?? '');
  }
}
