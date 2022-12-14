import 'package:equatable/equatable.dart';

import '../repositories/version_repository.dart';

class VersionModel extends Equatable {

  final VERSION_TYPES types;
  final String url;


  VersionModel(this.types, this.url);


  @override
  List<Object?> get props => [types, url];
}