import 'package:arquetipo_flutter_bloc/app/home/blocs/home_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/repositories/tasks_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;
    late TaskRepository taskRepository;

    setUp(() {
      taskRepository = MockTaskRepository();
      homeCubit = HomeCubit(taskRepository);
    });

    test('initial state is loading false and empty songs', () {
      expect(homeCubit.state.loading, false);
      expect(homeCubit.state.songs, []);
      expect(homeCubit.state.error, null);
    });

    blocTest<HomeCubit, HomeStateCubit>(
      'emits loading state and songs when loadSongs is called and songs are successfully fetched',
      build: () {
        when(() => taskRepository.getSongs()).thenAnswer((_) async => [
              const SongModel(
                "eligendi dolores adipisci",
                "http://loremflickr.com/640/480/nightlife",
                "Tia",
                "ad est ex",
                "self",
                "1",
              ),
              const SongModel(
                  "quasi quo quod",
                  "http://loremflickr.com/640/480/nature",
                  "Marlene",
                  "impedit at similique",
                  "self",
                  "2"),
            ]);
        return homeCubit;
      },
      act: (cubit) => cubit.loadSongs(),
      expect: () => [
        const HomeStateCubit(loading: true),
        const HomeStateCubit(
          loading: false,
          songs: [
            SongModel(
              "eligendi dolores adipisci",
              "http://loremflickr.com/640/480/nightlife",
              "Tia",
              "ad est ex",
              "self",
              "1",
            ),
            SongModel(
              "quasi quo quod",
              "http://loremflickr.com/640/480/nature",
              "Marlene",
              "impedit at similique",
              "self",
              "2",
            ),
          ],
        ),
      ],
    );
    final genericExpection =
        DioException(requestOptions: RequestOptions(path: ''),);
    blocTest<HomeCubit, HomeStateCubit>(
      'emits loading state and error when loadSongs is called and an error occurs',
      build: () {
        when(() => taskRepository.getTasks()).thenAnswer((_) async => throw genericExpection);
        return homeCubit;
      },
      act: (cubit) => cubit.loadSongs(),
      expect: () => [
        const HomeStateCubit(loading: true),
        HomeStateCubit(
          loading: false,
          error: genericExpection,
        ),
      ],
    );
  });
}
