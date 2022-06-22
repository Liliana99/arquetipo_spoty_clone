import 'package:arquetipo_flutter_bloc/app/shared/utils/environment/env.dart';
import 'package:arquetipo_flutter_bloc/env/environment_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/my-app.dart';
import 'app/shared/blocs/authentication/authentication_bloc.dart';
import 'app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'app/shared/blocs/error/error_cubit.dart';
import 'app/shared/interceptors/rest_interceptor.dart';
import 'app/shared/repositories/authentication_repository.dart';
import 'app/shared/providers/storage_provider.dart';
import 'package:dio/dio.dart';

void main() {
  const String envName = String.fromEnvironment('ENVIRONMENT', defaultValue: EnvDev.name);
  ENV().initConfig(envName);
  final StorageProvider storageProvider = StorageProvider();
  final dio = Dio(BaseOptions(
    baseUrl: ENV().config.basePath
  ));

  final authenticationRepository = AuthenticationRepository(storageProvider);
  final errorCubit = ErrorCubit();
  dio.interceptors.add(RestInterceptor(authenticationRepository, errorCubit));

  runApp(MultiRepositoryProvider(
    providers: [
      // Repositories
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository),
      // Providers
      RepositoryProvider<StorageProvider>(
          create: (context) => storageProvider),
      RepositoryProvider<Dio>(
          create: (context) => dio),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                AuthenticationState.unknown(),
                RepositoryProvider.of<AuthenticationRepository>(context))),
        BlocProvider(create: (BuildContext context) => errorCubit)
      ],
      child: MyApp(),
    ),
  ));
}
