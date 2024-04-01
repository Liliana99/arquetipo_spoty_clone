import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskRepository {
  final TaskProvider _tasksProvider;

  TaskRepository(this._tasksProvider);

  Future<List<TaskModel>> getTasks() {
    return _tasksProvider.getTasks();
  }

  Future<List<SongModel>> getSongs() async {
    return _tasksProvider.getSongs();
  }
}
