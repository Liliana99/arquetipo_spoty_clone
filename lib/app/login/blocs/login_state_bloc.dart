
import 'package:arquetipo_flutter_bloc/app/shared/models/password_form_model.dart';
import 'package:arquetipo_flutter_bloc/app/shared/models/username_form_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginBlocState extends Equatable {
  const LoginBlocState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.remember = false,
    this.pwdVisibility = false,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final bool remember;
  final bool pwdVisibility;

  LoginBlocState copyWith({
    FormzStatus status,
    Username username,
    Password password,
    bool remember,
    bool pwdVisibility,
  }) {
    return LoginBlocState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      remember: remember ?? this.remember,
      pwdVisibility: pwdVisibility ?? this.pwdVisibility,
    );
  }

  bool isValid() {
    return Formz.validate([this.username, this.password]).isValid;
  }

  @override
  List<Object> get props => [status, username, password, remember, pwdVisibility];
}