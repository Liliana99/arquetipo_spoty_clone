import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'task_provider.g.dart';

@RestApi()
abstract class TaskProvider {
  factory TaskProvider(Dio dio, {String baseUrl}) = _TaskProvider;

  @GET('task')
  Future<List<TaskModel>> getTasks();

  @GET('songs')
  Future<List<SongModel>> getSongs();
}
