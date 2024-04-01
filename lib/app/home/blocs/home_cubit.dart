import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../repositories/tasks_repository.dart';

class HomeCubit extends Cubit<HomeStateCubit> {
  final TaskRepository _tasksRepository;
  HomeCubit(this._tasksRepository) : super(const HomeStateCubit());

  loadSongs() async {
    emit(state.copyWith(loading: true));
    try {
      final songs = await _tasksRepository.getSongs();
      emit(state.copyWith(loading: false, songs: songs));
    } on DioException catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }
}
