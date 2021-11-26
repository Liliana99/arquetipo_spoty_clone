import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part "tasks_repository.g.dart";

@RestApi()
abstract class TasksRepository {

  factory TasksRepository(Dio dio, {String baseUrl}) = _TasksRepository;

  @GET('task')
  Future<List<TaskModel>> getTasks();
}