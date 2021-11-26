import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.network(task.avatar),
            title: Text(task.title),
            subtitle: Text(task.description),
          ),
        ],
      ),
    );
  }
}
