import 'dart:developer';

import 'package:pharmatask/Core/constants/constants.dart';
import 'package:pharmatask/Core/enums/auth_enum.dart';
import 'package:pharmatask/features/Authentication/data/model/auth_model.dart';
import 'package:pharmatask/services/sembast_database/sembast.dart';
import 'package:sembast/sembast.dart';

import 'authentication_abstract.dart';

class AuthDao implements AuthenticationAbstractDB {
  final _userStore = intMapStoreFactory.store(Constants.AUTH_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;
  var store = StoreRef.main();
  @override
  Future insert(AuthModel user) async {
    if (await checkIfUserExist(user, AuthType.signup) == false) {
      await _userStore.add(await _db, user.toMap()).then((value) {
        log("user added successfully... $value");
      });
    } else {
      throw "This user already exist";
    }
  }

  @override
  Future<String> retrieveLastOpenedUser() async {
    return await store.record('username').get(await _db) as String;
  }

  @override
  Future<void> login(AuthModel user) async {
    if (await checkIfUserExist(user, AuthType.login)) {
      await store.record('username').put(await _db, user.username);
    } else {
      throw "User not found";
    }
  }

  Future<bool> checkIfUserExist(AuthModel user, AuthType authType) async {
    Finder finder;
    if (authType == AuthType.login) {
      finder = Finder(
          filter: Filter.and([
        Filter.equals('username', user.username),
        Filter.equals('password', user.password)
      ]));
    } else {
      finder = Finder(
          filter: Filter.and([
        Filter.equals('username', user.username),
      ]));
    }
    var snapshots = await _userStore.find(await _db, finder: finder);
    log(snapshots.toString());
    if (snapshots.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future logout() async {
    await store.record('username').put(await _db, "");
  }
}
