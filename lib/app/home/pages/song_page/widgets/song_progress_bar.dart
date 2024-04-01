import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_state.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongProgressBar extends StatelessWidget {
  final SongCubit songCubit;

  const SongProgressBar({super.key, required this.songCubit});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            return ProgressBar(
              progress: songCubit.state.progress,
              buffered: songCubit.state.buffered,
              total: songCubit.state.total,
              progressBarColor: Colors.white,
              baseBarColor: Colors.white.withOpacity(0.24),
              bufferedBarColor: Colors.white.withOpacity(0.24),
              thumbColor: Colors.white,
              barHeight: 3.0,
              thumbRadius: 5.0,
              onSeek: (duration) {},
            );
          },
        ),
      ),
    );
  }
}
