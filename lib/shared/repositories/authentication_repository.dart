import 'dart:async';

import 'package:arquetipo_flutter_bloc/shared/repositories/storage_repository.dart';
import 'package:arquetipo_flutter_bloc/shared/repositories/user-model.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {

  final StorageRepository storage;
  final _controller = StreamController<AuthenticationStatus>();
  UserModel userModel;

  AuthenticationRepository(this.storage);

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
    bool rememberUser = false
  }) async {
    assert(username != null);
    assert(password != null);

    userModel = UserModel('token', username);

    if(rememberUser) {
      storage.saveUserData(userModel);
    }

    await Future.delayed(
      const Duration(milliseconds: 300),
          () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    storage.removeUserData();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<UserModel> getUsermodel() async  {
    if(storage.prefs == null) {
      await storage.init();
    }
    return storage.loadUserData();
  }

  void dispose() => _controller.close();
}