import '../../../features/Authentication/data/model/auth_model.dart';

abstract class AuthenticationAbstractDB {
  Future insert(AuthModel user);
  Future login(AuthModel user);
  Future logout();
  Future<String> retrieveLastOpenedUser();
}
