import 'package:arquetipo_flutter_bloc/app/login/blocs/bloc.dart';
import 'package:arquetipo_flutter_bloc/app/login/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(null, LoginRepository()),
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
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Image.asset('res/images/atSistemas_Logo.png'),
            ),
            LoginForm(),
          ],
        ),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UserNameInput(),
        _PasswordInput(),
        CheckboxListTile(
          title: const Text('Recordar usuario'),
          value: false,
          onChanged: (bool value) {},
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {},
              child: const Text('Login', style: TextStyle(fontSize: 20)),
            ),
          ),
        )
      ],
    );
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Username'),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );
  }
}
