import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';

import '../repository/auth_repo.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);
  Future<void> call(AuthModel authModel) async {
    return await repository.login(authModel);
  }
}
