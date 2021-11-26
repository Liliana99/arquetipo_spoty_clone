import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/repositories/tasks_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


class HomeCubit extends Cubit<HomeStateCubit> {
  final TasksRepository _tasksRepository;
  HomeCubit(this._tasksRepository) : super(HomeStateCubit());

  loadTasks() async {
    emit(state.copyWith(
      loading: true
    ));
    try {
      final tasks = await _tasksRepository.getTasks();
      emit(state.copyWith(
          loading: false,
          tasks: tasks
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e
      ));
    }
  }
}