import 'package:arquetipo_flutter_bloc/app/shared/utils/environment/environment.dart';

class EnvDev implements Environment {
  static const String name = 'DEV';
  String get basePath => 'https://6193e74e0b39a70017b15653.mockapi.io/';
  bool get production => false;
}