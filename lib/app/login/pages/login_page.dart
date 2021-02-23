import 'package:arquetipo_flutter_bloc/app/login/blocs/bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:arquetipo_flutter_bloc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(RepositoryProvider.of<AuthenticationRepository>(context)),
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
    final node = FocusScope.of(context);

    return Column(
      children: [
        _UserNameInput(node),
        _PasswordInput(node),
        _RememberUserInput(),
        _LoginButton()
      ],
    );
  }
}

class _UserNameInput extends StatelessWidget {
  final FocusScopeNode focusNode;

  _UserNameInput(this.focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginBlocState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onEditingComplete: () => focusNode.nextFocus(), // Move focus to next
          onChanged: (username) =>
              context.read<LoginBloc>().loginUsernameChanged(username),
          decoration: InputDecoration(
            hintText: S.of(context).username,
            errorText:
                state.username.invalid ? S.of(context).invalidUsername : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final FocusScopeNode focusNode;

  _PasswordInput(this.focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginBlocState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.status != current.status ||
          previous.pwdVisibility != current.pwdVisibility,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onEditingComplete: () => {focusNode.unfocus()},
          // Move focus to next
          obscureText: !state.pwdVisibility,
          onChanged: (password) =>
              context.read<LoginBloc>().loginPasswordChanged(password),
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(state.pwdVisibility ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                onPressed: () {
                  context.read<LoginBloc>().loginPasswordVisibilityChanged(!state.pwdVisibility);
                },
            ),
            hintText: S.of(context).password,
            errorText:
                state.password.invalid ? S.of(context).invalidPassword : null,
          ),
        );
      },
    );
  }
}

class _RememberUserInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginBlocState>(
        buildWhen: (previous, current) => previous.remember != current.remember,
        builder: (context, state) {
          return CheckboxListTile(
            title: Text(S.of(context).rememberUser),
            value: state.remember,
            onChanged: (bool remember) => {
              context.read<LoginBloc>().loginRememberChanged(remember),
            },
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: state.isValid()
                  ? () {
                      context.read<LoginBloc>().loginSubmitted();
                    }
                  : null,
              child: state.status == FormzStatus.submissionInProgress
                  ? SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : Text(S.of(context).loginButton,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
