import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';
import 'package:pharmatask/features/Authentication/domain/repository/auth_repo.dart';

class SignUpUsecase {
  final AuthRepository repository;
  SignUpUsecase(this.repository);
  Future<void> call(AuthModel authModel) async {
    print("usecase called with authModel");
    return await repository.signup(authModel);
  }
}
