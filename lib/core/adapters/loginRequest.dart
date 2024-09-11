import 'package:code_icons/data/model/request/login_request.dart';
import 'package:code_icons/data/model/response/auth_respnose/auth_response.dart';
import 'package:hive/hive.dart';

class LoginRequestAdapter extends TypeAdapter<LoginRequest> {
  @override
  final int typeId = 5;

  @override
  LoginRequest read(BinaryReader reader) {
    return LoginRequest(
      userName: reader.readString(),
      password: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, LoginRequest obj) {
    writer.writeString(obj.userName ?? '');
    writer.writeString(obj.password ?? '');
  }
}
