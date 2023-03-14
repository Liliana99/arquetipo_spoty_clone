import 'dart:ui';

import 'package:arquetipo_flutter_bloc/app/shared/blocs/authentication/authentication_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/version/version_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/version/version_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/version_repository.dart';
import 'package:arquetipo_flutter_bloc/app/shared/widgets/dialogs.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:arquetipo_flutter_bloc/theme.dart';
import 'package:go_router/go_router.dart';
import 'shared/blocs/error/error_cubit.dart';
import 'routes.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter router;

  @override
  void initState() {
    router = buildRoutes(BlocProvider.of<AuthenticationCubit>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        scrollBehavior: MyCustomScrollBehavior(),
        routerConfig: router,
        useInheritedMediaQuery: true,
        // TODO:  only for deveploment purpose
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.supportedLocales,
        theme: buildThemeData(),
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<ErrorCubit, DioError?>(
                listenWhen: (previous, current) => current != null,
                listener: (context, state) =>
                    buildErrorDialog(context, state, router),
              ),
              BlocListener<VersionCubit, VersionStateCubit>(
                listener: (context, state) {
                  print(state);
                  state.versionState == VERSION_TYPES.UPDATED
                      ? {}
                      : WidgetsBinding.instance.addPostFrameCallback((_) {
                          buildVersionBlockDialog(context, state, router);
                        });
                },
              )
            ],
            child: DevicePreview.appBuilder(context, child),
          );
        },
      ),
    );
  }
}
