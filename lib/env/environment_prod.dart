import 'package:arquetipo_flutter_bloc/app/shared/utils/environment/environment.dart';

class EnvProd implements Environment {
  static const String name = 'PROD';
  @override
  String get basePath => 'https://6193e74e0b39a70017b15653.mockapi.io/';
  @override
  bool get production => true;
}
