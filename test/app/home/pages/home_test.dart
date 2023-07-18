import 'dart:io';

import 'package:arquetipo_flutter_bloc/app/home/blocs/home_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/home_page.dart';
import 'package:arquetipo_flutter_bloc/app/home/repositories/tasks_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
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

    testWidgets('renders loading indicator correctly', (WidgetTester tester) async {
      when(() => homeCubit.state).thenReturn(HomeStateCubit(loading: true));
      await buildHomeWidget(homeCubit, tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders tasks list correctly', (WidgetTester tester) async {
      final tasks = [
        TaskModel('2022-01-01T00:00:00', 'Task 1', 'Description 1', 'https://example.com/avatar1.png', 'Username1', '1'),
        TaskModel('2022-01-01T00:00:00', 'Task 2', 'Description 2', 'https://example.com/avatar2.png', 'Username2', '2'),
      ];

      when(() => homeCubit.state).thenReturn(HomeStateCubit(loading: false, tasks: tasks));
      await buildHomeWidget(homeCubit, tester);

      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}

Future buildHomeWidget(MockHomeCubit homeCubit, WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.supportedLocales,
      home: Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (context) => homeCubit,
          child: HomeContent(),
        ),
      ),
    ),
  );

  await tester.pump(const Duration(milliseconds: 100));
}
