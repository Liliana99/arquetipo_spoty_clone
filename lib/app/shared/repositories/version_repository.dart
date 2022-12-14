import 'package:arquetipo_flutter_bloc/app/shared/models/version_model.dart';

enum VERSION_TYPES {
  INITIAL,
  UPDATED,
  OPTIONAL_UPDATE,
  MANDATORY_UPDATE
}

class VersionRepository {

  Future<VersionModel> checkVersion() async {
    await Future.delayed(Duration(milliseconds: 10));
    return VersionModel(VERSION_TYPES.OPTIONAL_UPDATE, ''); // TODO IMPLEMENT SERVICE
  }
}