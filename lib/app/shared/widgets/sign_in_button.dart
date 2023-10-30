import 'package:arquetipo_flutter_bloc/app/login/blocs/login_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/login/blocs/login_state_bloc.dart';
import 'package:arquetipo_flutter_bloc/app/shared/widgets/social_button_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigInButton extends StatelessWidget {
  const SigInButton({super.key, required this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 290,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), color: Colors.transparent),
      child: TextButton(
        onPressed: () => onTap!(),
        child: const Text(
          'Acceder',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SigInButtonWithOutPassword extends StatelessWidget {
  const SigInButtonWithOutPassword({super.key, required this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginBlocState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ButtonDecorationWitOutPassword(
          child: TextButton(
            onPressed: () => onTap!(),
            child: state.submissionInProgress
                ? const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      key: Key('circular_progress_indicator'),
                      backgroundColor: Colors.white,
                    ),
                  )
                : Text(
                    'Log in without password',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
          ),
        ),
      );
    });
  }
}
