import 'package:arquetipo_flutter_bloc/app/shared/blocs/version/version_state_cubit.dart';
import 'package:arquetipo_flutter_bloc/app/shared/repositories/version_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionCubit extends Cubit<VersionStateCubit> {
  final VersionRepository versionRepository;

  VersionCubit(this.versionRepository)
      : super(const VersionStateCubit(
            url: '', versionState: VersionTypes.initial));

  init() async {
    final result = await versionRepository.checkVersion();
    emit(state.copyWith(versionState: result.types, url: result.url));
  }
}
