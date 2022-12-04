import 'package:pharmatask/Core/enums/auth_enum.dart';

extension AuthFieldsParse on AuthFields {
  String parseFields(AuthFields field) {
    if (field == AuthFields.password) {
      return "Password";
    }
    return "Username";
  }
}
