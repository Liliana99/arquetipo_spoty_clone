import 'package:arquetipo_flutter_bloc/app/home/blocs/home_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/utils/capitalize_first_ch.dart';
import 'package:arquetipo_flutter_bloc/app/home/utils/songs_group.dart';
import 'package:arquetipo_flutter_bloc/app/home/widgets/task_widget.dart';
import 'package:arquetipo_flutter_bloc/consts/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/bottom_menu_widget.dart';
import '../blocs/home_cubit.dart';
import '../providers/task_provider.dart';
import '../repositories/tasks_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(
              TaskRepository(
                TaskProvider(
                  RepositoryProvider.of<Dio>(context),
                ),
              ),
            )..loadSongs(),
        child: const HomeContent());
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var actionsButtons = [
      SizedBox(
        width: 20,
        height: 20,
        child: Image.asset(
          Assets.bell,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      const Icon(
        Icons.alarm,
        color: Colors.white,
      ),
      const SizedBox(
        width: 10,
      ),
      const Icon(Icons.settings),
      const SizedBox(
        width: 10,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Made for Liliana',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        actions: actionsButtons,
      ),
      bottomNavigationBar: const BottomMenu(0),
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
                  context.read<HomeCubit>().loadSongs();
                },
                child: HomeGrid(songs: state.songs));
          }
        },
      ),
    );
  }
}

class HomeGrid extends StatefulWidget {
  final List<SongModel> songs;

  const HomeGrid({required this.songs});

  @override
  _HomeGridState createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<SongModel>> songsByGroup = songsGroupByType(widget.songs);
    List<SongModel> songList = flattenSongs(songsByGroup);
    return ListView(
      shrinkWrap: true,
      children: songsByGroup.keys.map((type) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              child: Text(capitalizeFirstLetter(type),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(songList.length, (index) {
                  return Column(
                    children: [
                      SongBody(
                        songList[index],
                        goToSong: () {
                          GoRouter.of(context)
                              .push('/songpage', extra: songList[index]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SongDetailsWidget(songItem: songList[index]),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
