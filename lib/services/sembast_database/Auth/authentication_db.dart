import 'dart:developer';

import 'package:pharmatask/Core/constants/constants.dart';
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
    if (await checkIfUserExist(user) == false) {
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
    if (await checkIfUserExist(user)) {
      await store.record('username').put(await _db, user.username);
    } else {
      throw "User not found";
    }
  }

  Future<bool> checkIfUserExist(AuthModel user) async {
    bool userFound = false;
    final recordSnapshots = await _userStore.find(
      await _db,
    );
    print(user.username);
    print(user.password);

    for (int i = 0; i < recordSnapshots.length; i++) {
      if ((recordSnapshots[i].value['username'].toString().trim() ==
              user.username.trim()) &&
          (recordSnapshots[i].value['password'].toString().trim() ==
              user.password.trim())) {
        userFound = true;
        break;
      }
    }
    return userFound;
  }

  @override
  Future logout() async {
    await store.record('username').put(await _db, "");
  }
}
