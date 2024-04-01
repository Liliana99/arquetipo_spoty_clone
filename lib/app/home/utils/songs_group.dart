import 'package:arquetipo_flutter_bloc/app/home/models/song_model.dart';

Map<String, List<SongModel>> songsGroupByType(List<SongModel> list) {
  Map<String, List<SongModel>> mapByGroup = {};

  for (var song in list) {
    if (mapByGroup.containsKey(song.type)) {
      mapByGroup[song.type]!.add(song);
    } else {
      mapByGroup[song.type] = [song];
    }
  }

  return mapByGroup;
}

List<SongModel> flattenSongs(Map<String, List<SongModel>> mapa) {
  List<SongModel> songModelListGroup = [];

  mapa.forEach((key, value) {
    songModelListGroup.addAll(value);
  });

  return songModelListGroup;
}
