import 'package:arquetipo_flutter_bloc/shared/blocs/authentication/authentication_bloc.dart';
import 'package:arquetipo_flutter_bloc/shared/blocs/authentication/authentication_state_bloc.dart';
import 'package:arquetipo_flutter_bloc/shared/repositories/authentication_repository.dart';
import 'package:arquetipo_flutter_bloc/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              buildWhen: (previous, current) => current.status == AuthenticationStatus.authenticated,
              builder: (context, state) {
                print(state.status);
            return Text(state.user.userName);
          }),
        ),
        bottomNavigationBar: BottomMenu(0));
  }
}
