import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_state.dart';
import 'package:arquetipo_flutter_bloc/consts/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongNameWithIcon extends StatelessWidget {
  final SongModel songItem;


  const SongNameWithIcon({super.key, required this.songItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              Text(
                songItem.name,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Flexible(
          child: BlocBuilder<SongCubit, SongState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<SongCubit>(context).toogleHeartIcon(state );
                },
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: !state.isIconActive
                      ? Image.asset(
                          Assets.heart,
                          color: Colors.white,
                        )
                      : Image.asset(Assets.whiteheart),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
