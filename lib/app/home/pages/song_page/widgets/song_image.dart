import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';
import 'package:flutter/material.dart';

class SongImage extends StatelessWidget {
  final SongModel songItem;
  const SongImage({super.key, required this.songItem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Image.network(
        songItem.cover!,
        fit: BoxFit.cover,
      ),
    );
  }
}
