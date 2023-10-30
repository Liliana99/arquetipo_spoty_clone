import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_state.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/song_progress_bar.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/song_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongButtons extends StatelessWidget {
  final SongCubit songCubit;
 
  const SongButtons(
      {super.key,
      required this.songCubit,
      });

  Icon updatePlayIcon(SongCubit songCubit) {
    return songCubit.state.buttonState == ButtonState.pause
        ? const Icon(
            Icons.play_arrow,
          )
        : const Icon(Icons.pause);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          SongProgressBar(songCubit: songCubit),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButtonSong(
                icon: const Icon(Icons.shuffle),
                ontap: () {},
              ),
              IconButtonSong(
                icon: const Icon(Icons.skip_previous),
                ontap: () {
                  songCubit.backProgress();
                },
              ),
              BlocBuilder<SongCubit, SongState>(
                builder: (context, state) {
                  return IconButtonSong(
                    icon: updatePlayIcon(songCubit),
                    backGroundColor: state.buttonState == ButtonState.pause|| state.buttonState==ButtonState.playing ?  Colors.white:null,
                    ontap: () {
                      songCubit
                          .toogleButtonMusic(songCubit.state);
                    },
                  );
                },
              ),
              IconButtonSong(
                icon: const Icon(
                  Icons.skip_next,
                ),
                ontap: () {
                  songCubit.forwardProgress();
                },
              ),
              IconButtonSong(icon: const Icon(Icons.swap_horiz), ontap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
