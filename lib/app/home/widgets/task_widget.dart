import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:arquetipo_flutter_bloc/consts/assets_constants.dart';
import 'package:flutter/material.dart';

class SongBody extends StatelessWidget {
  final SongModel songItem;
  final VoidCallback goToSong;
  const SongBody(this.songItem, {super.key, required this.goToSong});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 14);
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SongImageWidget(
            onTap: goToSong, songItem: songItem, textStyle: textStyle),
      ),
    );
  }
}

class SongImageWidget extends StatelessWidget {
  const SongImageWidget({
    super.key,
    required this.songItem,
    required this.textStyle,
    required this.onTap,
  });

  final SongModel songItem;
  final TextStyle textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              songItem.cover!,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.logoSpotify,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongDetailsWidget extends StatelessWidget {
  final SongModel songItem;
  const SongDetailsWidget({super.key, required this.songItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(songItem.name),
        if (songItem.albumname != null) Text(songItem.albumname!),
        if (songItem.artist != null) Text(songItem.artist!),
      ],
    );
  }
}
