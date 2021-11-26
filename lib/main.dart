import 'package:arquetipo_flutter_bloc/app/shared/utils/environment/env.dart';
import 'package:arquetipo_flutter_bloc/env/environment_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/my-app.dart';
import 'app/shared/blocs/authentication/authentication_bloc.dart';
import 'app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'app/shared/repositories/authentication_repository.dart';
import 'app/shared/repositories/storage_repository.dart';
import 'package:dio/dio.dart';

void main() {
  const String envName = String.fromEnvironment('ENVIRONMENT', defaultValue: EnvDev.name);
  ENV().initConfig(envName);
  final StorageRepository storageRepository = StorageRepository();
  final dio = Dio(BaseOptions(
    baseUrl: ENV().config.basePath
  ));

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(storageRepository)),
      RepositoryProvider<StorageRepository>(
          create: (context) => storageRepository),
      RepositoryProvider<Dio>(
          create: (context) => dio),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(
                AuthenticationState.unknown(),
                RepositoryProvider.of<AuthenticationRepository>(context)))
      ],
      child: MyApp(),
    ),
  ));
}
