import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel extends Equatable {
  final String id;
  final String name;
  final String? cover;
  final String? artist;
  final String? albumname;
  final String type;

  const SongModel(
      this.name, this.cover, this.artist, this.albumname, this.type, this.id);

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongModelToJson(this);

  @override
  List<Object?> get props => [id,name,cover,artist,albumname,type];
}
