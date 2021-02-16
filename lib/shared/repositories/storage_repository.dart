import 'package:arquetipo_flutter_bloc/shared/repositories/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  SharedPreferences prefs;

  StorageRepository() {}

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveUserData(UserModel user) {
    prefs.setString('token', user.token);
    prefs.setString('userName', user.userName);
  }

  void removeUserData() {
    prefs.remove('token');
    prefs.remove('userName');
  }

  UserModel loadUserData() {
    String token = prefs.getString('token');
    String userName = prefs.getString('userName');

    if(token == null) {
      return null;
    }

    return UserModel(token, userName);
  }
}