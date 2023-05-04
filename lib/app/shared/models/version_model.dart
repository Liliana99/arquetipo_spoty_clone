import 'package:equatable/equatable.dart';

import '../repositories/version_repository.dart';

class VersionModel extends Equatable {
  final VersionTypes types;
  final String url;

  const VersionModel(this.types, this.url);

  @override
  List<Object?> get props => [types, url];
}
