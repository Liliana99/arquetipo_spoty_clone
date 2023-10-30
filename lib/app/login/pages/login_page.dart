import 'package:arquetipo_flutter_bloc/app/login/blocs/cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';

import 'package:arquetipo_flutter_bloc/app/shared/widgets/sign_in_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.read<LoginCubit>().backToSplash(),
              icon: const Icon(Icons.arrow_back_ios_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: LoginForm(),
                ),
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context)!.emailTitle,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              child: _UserNameInput(node)),
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context)!.passwordTitle,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              child: _PasswordInput(node)),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.height * 0.20,
              child: const _LoginButton()),
          SigInButtonWithOutPassword(
            onTap: () {
              BlocProvider.of<LoginCubit>(context).loginWithOutPassword();
            },
          )
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
      decoration: const InputDecoration(
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

  bool isValidState(LoginBlocState state) => state.isValid();

  ButtonStyle? setLoginButtonStyle(LoginBlocState state) {
    if (isValidState(state)) {
      return ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(const Color.fromARGB(255, 5, 5, 5)),
        enableFeedback: true,
      );
    }
    return ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(const Color.fromARGB(77, 140, 138, 138)),
      enableFeedback: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<LoginCubit, LoginBlocState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: setLoginButtonStyle(state),
                  key: const Key('loginForm_submit_button'),
                  onPressed: state.isValid()
                      ? () => context.read<LoginCubit>().loginSubmitted()
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context)!.loginButton,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isValidState(state)
                              ? Colors.white
                              : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
