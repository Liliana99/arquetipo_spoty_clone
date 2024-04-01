import 'package:arquetipo_flutter_bloc/app/shared/repositories/version_repository.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'version_state_cubit.g.dart';

@CopyWith()
class VersionStateCubit extends Equatable {
  final VersionTypes versionState;
  final String url;

  const VersionStateCubit(
      {this.versionState = VersionTypes.initial, this.url = ''});

  @override
  List<Object?> get props => [versionState];
}
