import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';
import 'package:pharmatask/features/Authentication/domain/repository/auth_repo.dart';

import '../../../../services/sembast_database/Auth/authentication_db.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthDao authDao;
  AuthRepoImpl(this.authDao);
  @override
  Future<void> login(AuthModel authModel) async {
    await authDao.login(authModel);
  }

  @override
  Future<void> signup(AuthModel authModel) async {
    await authDao.insert(authModel);
  }
}
