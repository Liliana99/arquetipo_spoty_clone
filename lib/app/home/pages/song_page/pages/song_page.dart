import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';

import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/blocs/song_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/app_bar_title.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/song_buttons.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/song_image.dart';
import 'package:arquetipo_flutter_bloc/app/home/pages/song_page/widgets/song_name_with_icon.dart';
import 'package:arquetipo_flutter_bloc/consts/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SongCubit(
             
            ),
        child:  const SongContent(songItem: SongModel('', '', '', '', '', '')));
}}

class SongContent extends StatelessWidget {
  final SongModel songItem;

  const SongContent({super.key, required this.songItem});
  @override
  Widget build(BuildContext context) {
    final songCubit = context.watch<SongCubit>();
 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
              songCubit.resetButtonsMusic(ButtonState.pause);
              songCubit.backProgress();
              songCubit.resetIcon();
            },
            icon: Image.asset(Assets.arrowDown,),),
        title: const AppBarTitle(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              SongImage(
                songItem: songItem,
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (songItem.albumname != null)
                        Text(
                          songItem.albumname!,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      SongNameWithIcon(
                        songItem: songItem,
                      ),
                      if (songItem.artist != null)
                        Flexible(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              songItem.artist!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SongButtons(
                songCubit: songCubit,
              ),
            ]),
      ),
    );
  }
}
