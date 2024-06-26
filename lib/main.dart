import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/blocs/version/version_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/utils/environment/env.dart';
import 'package:arquetipo_flutter_bloc/env/environment_dev.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/my_app.dart';
import 'app/shared/blocs/authentication/authentication_cubit.dart';
import 'app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'app/shared/blocs/error/error_cubit.dart';
import 'app/shared/interceptors/rest_interceptor.dart';
import 'app/shared/repositories/authentication_repository.dart';
import 'app/shared/providers/storage_provider.dart';
import 'package:dio/dio.dart';

import 'app/shared/repositories/version_repository.dart';
import 'app/shared/utils/platform_checker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  const String envName =
      String.fromEnvironment('ENVIRONMENT', defaultValue: EnvDev.name);
  ENV().initConfig(envName);
  final StorageProvider storageProvider = StorageProvider();
  final dio = Dio(BaseOptions(baseUrl: ENV().config.basePath));

  final authenticationRepository = AuthenticationRepository(storageProvider);
  final errorCubit = ErrorCubit();
  final songCubit = SongCubit();

  dio.interceptors.add(RestInterceptor(authenticationRepository, errorCubit));

  runApp(MultiRepositoryProvider(
    providers: [
      // Repositories
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository),

      // Providers
      RepositoryProvider<StorageProvider>(create: (context) => storageProvider),
      RepositoryProvider<Dio>(create: (context) => dio),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
            create: (BuildContext context) => AuthenticationCubit(
                const AuthenticationState.unknown(),
                RepositoryProvider.of<AuthenticationRepository>(context))
              ..initAuthentication()),
        BlocProvider(create: (BuildContext context) => errorCubit),
        BlocProvider(create: (BuildContext context) => songCubit),
        BlocProvider(
            create: (BuildContext context) =>
                VersionCubit(VersionRepository())..init())
      ],
      child: DevicePreview(
          enabled: !kReleaseMode && Util().isComputer(),
          builder: (context) => const MyApp()),
    ),
  ));
}
