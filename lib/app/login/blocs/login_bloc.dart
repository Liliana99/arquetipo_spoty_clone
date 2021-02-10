import 'package:arquetipo_flutter_bloc/app/login/repositories/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {

  final LoginRepository repository;

  LoginBloc(LoginBlocState initialState, this.repository) : super(initialState);

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
