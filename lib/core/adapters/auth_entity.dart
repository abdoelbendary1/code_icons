import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:code_icons/data/model/response/auth_respnose/loginScreen.dart';
import 'package:hive/hive.dart';

class AuthResponseDMAdapter extends TypeAdapter<AuthResponseDM> {
  @override
  final int typeId = 1;

  @override
  AuthResponseDM read(BinaryReader reader) {
    return AuthResponseDM(
      id: reader.readInt(),
      username: reader.readString(),
      name: reader.readString(),
      accessToken: reader.readString(),
      message: reader.readString(),
      screens: reader.readList().cast<LoginScreensDM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AuthResponseDM obj) {
    writer.writeInt(obj.id ?? 0);
    writer.writeString(obj.username ?? '');
    writer.writeString(obj.name ?? '');
    writer.writeString(obj.accessToken ?? '');
    writer.writeString(obj.message ?? '');
    writer.writeList(obj.screens ?? []);
  }
}
