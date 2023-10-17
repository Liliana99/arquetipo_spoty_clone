import 'package:arquetipo_flutter_bloc/app/login/blocs/cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:arquetipo_flutter_bloc/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../consts/assets_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const LoginContent(),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

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
              child: Image.asset(Assets.logoAT),
            ),
            LoginForm(),
          ],
        ),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return FormBuilder(
      key: formKey,
      onChanged: () {
        formKey.currentState!.save();
        BlocProvider.of<LoginCubit>(context).formChanged(
            formKey.currentState!.value, formKey.currentState!.isValid);
      },
      child: Column(
        children: [
          _UserNameInput(node),
          _PasswordInput(node),
          _RememberUserInput(),
          const _LoginButton()
        ],
      ),
    );
  }
}

class _UserNameInput extends StatelessWidget {
  final FocusScopeNode focusNode;

  const _UserNameInput(this.focusNode);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: const Key('loginForm_usernameInput_textField'),
      name: 'userName',
      onEditingComplete: () => focusNode.nextFocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Move focus to next
      decoration: InputDecoration(
        hintText: S.of(context)!.username,
      ),
      validator: FormBuilderValidators.required(
          errorText: S.of(context)!.invalidUsername),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final FocusScopeNode focusNode;

  const _PasswordInput(this.focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginBlocState>(
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'password',
          key: const Key('loginForm_passwordInput_textField'),
          onEditingComplete: () => {focusNode.unfocus()},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // Move focus to next
          obscureText: !state.pwdVisibility,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              key: const Key('loginForm_eyeIcon_button'),
              icon: Icon(state.pwdVisibility
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined),
              onPressed: () {
                context
                    .read<LoginCubit>()
                    .loginPasswordVisibilityChanged(!state.pwdVisibility);
              },
            ),
            hintText: S.of(context)!.password,
          ),
          validator: FormBuilderValidators.required(
              errorText: S.of(context)!.invalidPassword),
        );
      },
    );
  }
}

// Custom form builder example
class _RememberUserInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: 'remember',
      key: const Key('loginForm_remember_textField'),
      initialValue: false,
      builder: (FormFieldState<bool> field) {
        return CheckboxListTile(
          key: const Key('loginForm_remember_textField'),
          title: Text(S.of(context)!.rememberUser),
          value: field.value,
          onChanged: (bool? remember) => {
            field.didChange(remember),
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const Key('loginForm_submit_button'),
              onPressed: state.isValid()
                  ? () => context.read<LoginCubit>().loginSubmitted()
                  : null,
              child: state.submissionInProgress
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          key: Key('circular_progress_indicator'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.of(context)!.loginButton),
                    ),
            ),
          ),
        );
      },
    );
  }
}
