import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationState> {

  final AuthenticationRepository repository;

  AuthenticationBloc(AuthenticationState initialState, this.repository) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationBlocEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}