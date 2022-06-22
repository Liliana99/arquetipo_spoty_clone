import 'dart:async';
import 'package:arquetipo_flutter_bloc/app/shared/models/user-model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/providers/storage_provider.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {

  final StorageProvider storage;
  final _controller = StreamController<AuthenticationStatus>();
  UserModel? userModel;
  String? token;

  AuthenticationRepository(this.storage);

  String? get Token {
    return token;
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
    bool rememberUser = false
  }) async {
    userModel = UserModel('token', username);

    if(rememberUser) {
      storage.saveUserData(userModel!);
    }

    await Future.delayed(
      const Duration(milliseconds: 300),
          () => _controller.add(AuthenticationStatus.authenticated),
    );
    token = "token";
  }

  void logOut() {
    storage.removeUserData();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<UserModel?> getUsermodel() async  {
    if(storage.prefs == null) {
      await storage.init();
    }

    final userData = storage.loadUserData();
    userModel = userData;

    if(userModel != null) {
      token = userModel!.token;
    }

    return userModel;
  }

  void dispose() => _controller.close();

  bool isLogued() {
    return token != null;
  }

}