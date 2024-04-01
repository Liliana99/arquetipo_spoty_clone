import 'package:arquetipo_flutter_bloc/app/login/blocs/login_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/authentication_repository.dart';
import 'package:arquetipo_flutter_bloc/app/shared/widgets/sign_in_button.dart';
import 'package:arquetipo_flutter_bloc/app/shared/widgets/social_button.dart';
import 'package:arquetipo_flutter_bloc/consts/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(
            RepositoryProvider.of<AuthenticationRepository>(context)),
        child: const SplashContent(),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: Image.asset(
                Assets.logoSpotify,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextBuilder(
              text: 'Milions of songs.',
            ),
            const TextBuilder(
              text: 'Free on spotiy.',
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const ResizableColumnWidget(
          widget: SocialButton(title: 'Registrate gratis', path: null),
        ),
        const SizedBox(
          height: 20,
        ),
        const ResizableColumnWidget(
          widget: SocialButton(
              title: 'Continua con Google', path: Assets.logoGoogle),
        ),
        const SizedBox(
          height: 20,
        ),
        const ResizableColumnWidget(
          widget: SocialButton(
              title: 'Continua con Facebook', path: Assets.logoFace),
        ),
        const SizedBox(
          height: 20,
        ),
        ResizableColumnWidget(
          widget:
              SigInButton(onTap: () => context.read<LoginCubit>().splashTap()),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ResizableColumnWidget extends StatelessWidget {
  const ResizableColumnWidget({
    super.key,
    required this.widget,
  });
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 0.10,
        child: Column(
          children: [widget],
        ));
  }
}

class TextBuilder extends StatelessWidget {
  const TextBuilder({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 36),
    );
  }
}
