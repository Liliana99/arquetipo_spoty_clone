import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/task_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../blocs/home_cubit.dart';
import '../providers/task_provider.dart';
import '../repositories/tasks_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(
            TaskRepository(TaskProvider(RepositoryProvider.of<Dio>(context))))
          ..loadTasks(),
        child: HomeContent());
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<HomeCubit, HomeStateCubit>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeCubit>().loadTasks();
                },
                child: HomeGrid(tasks: state.tasks));
          }
        },
      ),
    );
  }
}

class HomeGrid extends StatefulWidget {
  final List<TaskModel> tasks;

  HomeGrid({required this.tasks});

  @override
  _HomeGridState createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return _animatedTaskWidget(index);
      },
    );
  }

  Widget _animatedTaskWidget(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: opacity,
            child: child,
          ),
        );
      },
      child: TaskWidget(widget.tasks[index]),
    );
  }
}
