import 'dart:async';
import 'package:arquetipo_flutter_bloc/app/shared/models/user_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/providers/storage_provider.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final StorageProvider storage;
  final _controller = StreamController<AuthenticationStatus>();
  UserModel? userModel;
  String? _token;

  AuthenticationRepository(this.storage);

  String? get token {
    return _token;
  }

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<void> logIn(
      {required String username,
      required String password,
      bool rememberUser = false}) async {
    userModel = UserModel('token', username);

    if (rememberUser) {
      storage.saveUserData(userModel!);
    }

    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
    _token = "token";
  }

  Future<void> doSplash() async {
    await Future.delayed(
      const Duration(milliseconds: 30),
      () => _controller.add(AuthenticationStatus.unknown),
    );
  }

  Future<void> backToSplashPage() async {
    await Future.delayed(
      const Duration(milliseconds: 30),
      () => _controller.add(AuthenticationStatus.unauthenticated),
    );
  }

  void logOut() {
    storage.removeUserData();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<UserModel?> getUsermodel() async {
    if (storage.prefs == null) {
      await storage.init();
    }

    final userData = storage.loadUserData();
    userModel = userData;

    if (userModel != null) {
      _token = userModel!.token;
    }

    return userModel;
  }

  void dispose() => _controller.close();

  bool isLogged() {
    return _token != null;
  }

  Future<void> logInWithOutPassword() async {
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _controller.add(AuthenticationStatus.authenticated);
    });
  }
}
