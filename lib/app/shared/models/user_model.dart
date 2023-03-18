import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String token;
  final String? userName;

  const UserModel(this.token, this.userName);

  @override
  List<Object?> get props => [token, userName];
}
