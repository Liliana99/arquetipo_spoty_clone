import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String createdAt;
  final String title;
  final String description;
  final String avatar;
  final String username;
  final String id;

  TaskModel(this.createdAt, this.title, this.description, this.avatar,
      this.username, this.id);

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}