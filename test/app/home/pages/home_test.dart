import 'dart:io';

import 'package:arquetipo_flutter_bloc/app/home/blocs/home_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/repositories/tasks_repository.dart';
import 'package:arquetipo_flutter_bloc/app/home/utils/capitalize_first_ch.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockHomeCubit extends MockCubit<HomeStateCubit> implements HomeCubit {}

class FakeHomeStateCubit extends Fake implements HomeStateCubit {}

class MockTaskRepository extends Mock implements TaskRepository {}

class MockDio extends Mock implements Dio {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeHomeStateCubit());
    HttpOverrides.global = null;
  });

  group('HomeContent', () {
    late MockHomeCubit homeCubit;
    late MockTaskRepository taskRepository;
    late MockDio dio;

    setUp(() {
      homeCubit = MockHomeCubit();
      taskRepository = MockTaskRepository();
      dio = MockDio();
    });

    testWidgets('renders loading indicator correctly',
        (WidgetTester tester) async {
      when(() => homeCubit.state)
          .thenReturn(const HomeStateCubit(loading: true));
      await buildHomeWidget(homeCubit, tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders tasks list correctly and finds text self correctly',
        (WidgetTester tester) async {
      final songs = [
        const SongModel(
            'eligendi dolores adipisci',
            'http://loremflickr.com/640/480/nightlife',
            'Tia',
            'ad est ex',
            'self',
            '1'),
        const SongModel(
            'quasi quo quod',
            'http://loremflickr.com/640/480/nature',
            'Marlene',
            'impedit at similique',
            'self',
            '2'),
        const SongModel(
            'nesciunt quaerat aut',
            'http://loremflickr.com/640/480/technics',
            'Diana',
            'autem alias dignissimos',
            'self',
            '3'),
      ];

      when(() => homeCubit.state)
          .thenReturn(HomeStateCubit(loading: false, songs: songs));
      await buildHomeWidget(homeCubit, tester);
      verifySingleCapitalizedTextWidget('self');
    });
  });
}

void verifySingleCapitalizedTextWidget(String type) {
  final textFinder = find.text(capitalizeFirstLetter(type));
  expect(textFinder, findsOneWidget);
}

Future buildHomeWidget(MockHomeCubit homeCubit, WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.supportedLocales,
      home: Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (context) => homeCubit,
          child: const HomeContent(),
        ),
      ),
    ),
  );

  await tester.pump(const Duration(milliseconds: 100));
}
