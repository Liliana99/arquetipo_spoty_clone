import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: ClipOval(
                  child: Container(
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxWidth * 0.25,
                    child: Image.network(
                      task.avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
