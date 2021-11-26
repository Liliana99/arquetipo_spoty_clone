import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/my-app.dart';
import 'app/shared/blocs/authentication/authentication_bloc.dart';
import 'app/shared/blocs/authentication/authentication_state_bloc.dart';
import 'app/shared/repositories/authentication_repository.dart';
import 'app/shared/repositories/storage_repository.dart';


void main() {
  final StorageRepository storageRepository = StorageRepository();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(storageRepository)),
      RepositoryProvider<StorageRepository>(
          create: (context) => storageRepository),
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
