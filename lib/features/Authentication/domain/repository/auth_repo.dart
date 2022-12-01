import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';

abstract class AuthRepository {
  Future<void> login(AuthModel authModel);
  Future<void> signup(AuthModel authModel);
}
