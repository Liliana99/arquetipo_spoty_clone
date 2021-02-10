import 'package:arquetipo_flutter_bloc/app/login/blocs/bloc.dart';
import 'package:arquetipo_flutter_bloc/app/login/repositories/login_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      LoginBloc(null, LoginRepository()),
      child: LoginContent(),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Test')
    );
  }
}
