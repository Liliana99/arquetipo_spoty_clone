import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'home_state_cubit.g.dart';

@CopyWith()
class HomeStateCubit extends Equatable {
  final List<SongModel> songs;
  final bool loading;
  final DioException? error;

  const HomeStateCubit({
    this.songs = const [],
    this.loading = false,
    this.error,
  });

  @override
  List<Object?> get props => [songs, loading, error];
}
