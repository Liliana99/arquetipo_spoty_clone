import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskRepository {
  final TaskProvider _tasksProvider;

  TaskRepository(this._tasksProvider);

  Future<List<TaskModel>> getTasks() {
    return _tasksProvider.getTasks();
  }
}