import 'package:arquetipo_flutter_bloc/app/home/blocs/home_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
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

    test('initial state is loading false and empty tasks', () {
      expect(homeCubit.state.loading, false);
      expect(homeCubit.state.tasks, []);
      expect(homeCubit.state.error, null);
    });

    blocTest<HomeCubit, HomeStateCubit>(
      'emits loading state and tasks when loadTasks is called and tasks are successfully fetched',
      build: () {
        when(() => taskRepository.getTasks()).thenAnswer((_) async => [
          TaskModel("2023-05-01", "Task 1", "Task description 1", "https://example.com/avatar1.png", "user1", "1"),
          TaskModel("2023-05-02", "Task 2", "Task description 2", "https://example.com/avatar2.png", "user2", "2"),
        ]);
        return homeCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      expect: () => [
        HomeStateCubit(loading: true),
        HomeStateCubit(loading: false, tasks: [
          TaskModel("2023-05-01", "Task 1", "Task description 1", "https://example.com/avatar1.png", "user1", "1"),
          TaskModel("2023-05-02", "Task 2", "Task description 2", "https://example.com/avatar2.png", "user2", "2"),
        ]),
      ],
    );
    final genericExpection = DioException(requestOptions: RequestOptions(path: ''));
    blocTest<HomeCubit, HomeStateCubit>(
      'emits loading state and error when loadTasks is called and an error occurs',
      build: () {
        when(() => taskRepository.getTasks())
            .thenThrow(genericExpection);
        return homeCubit;
      },
      act: (cubit) => cubit.loadTasks(),
      expect: () => [
        HomeStateCubit(loading: true),
        HomeStateCubit(
          loading: false,
          error: genericExpection,
        ),
      ],
    );
  });
}
