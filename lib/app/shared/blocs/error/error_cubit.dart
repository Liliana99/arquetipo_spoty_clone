import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorCubit extends Cubit<DioError?> {

  ErrorCubit() : super(null);

  showRestError(DioError error) {
    emit(error);
  }
}

