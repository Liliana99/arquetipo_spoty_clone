import 'package:arquetipo_flutter_bloc/app/shared/models/version_model.dart';

enum VersionTypes { initial, updated, optionalUpdate, mandatoryUpdate }

class VersionRepository {
  Future<VersionModel> checkVersion() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return const VersionModel(
        VersionTypes.optionalUpdate, ''); // TODO IMPLEMENT SERVICE
  }
}
