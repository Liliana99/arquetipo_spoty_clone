import 'package:arquetipo_flutter_bloc/app/home/blocs/home_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/providers/task_provider.dart';
import 'package:arquetipo_flutter_bloc/app/home/widgets/task_widget.dart';
import 'package:arquetipo_flutter_bloc/app/shared/widgets/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../repositories/tasks_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(
            TaskRepository(TaskProvider(RepositoryProvider.of<Dio>(context))))
          ..loadTasks(),
        child: const HomeContent());
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: BlocBuilder<HomeCubit, HomeStateCubit>(
                builder: (context, state) {
              return state.loading
                  ? const CircularProgressIndicator()
                  : TaskList(state.tasks);
            }),
          ),
        ),
        bottomNavigationBar: const BottomMenu(0));
  }
}

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  const TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskWidget(tasks[index]);
        });
  }
}
