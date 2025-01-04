import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:hive/hive.dart';
import 'loginScreen.dart'; // Import your LoginScreensDM class

class LoginScreensDMAdapter extends TypeAdapter<LoginScreensDM> {
  @override
  final int typeId = 6; // Make sure this typeId is unique

  @override
  LoginScreensDM read(BinaryReader reader) {
    return LoginScreensDM(
      id: reader.readInt(),
      userId: reader.readInt(),
      formId: reader.readInt(),
      modules: reader.readString(),
      canRead: reader.readBool(),
      canCreate: reader.readBool(),
      canUpdate: reader.readBool(),
      canDelete: reader.readBool(),
      canPrint: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, LoginScreensDM obj) {
    writer.writeInt(obj.id ?? 0);
    writer.writeInt(obj.userId ?? 0);
    writer.writeInt(obj.formId ?? 0);
    writer.writeString(obj.modules ?? '');
    writer.writeBool(obj.canRead ?? false);
    writer.writeBool(obj.canCreate ?? false);
    writer.writeBool(obj.canUpdate ?? false);
    writer.writeBool(obj.canDelete ?? false);
    writer.writeBool(obj.canPrint ?? false);
  }
}
