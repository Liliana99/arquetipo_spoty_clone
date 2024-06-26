import 'dart:developer';

import 'package:dio/dio.dart';

import '../blocs/error/error_cubit.dart';
import '../repositories/authentication_repository.dart';

class RestInterceptor extends Interceptor {
  final AuthenticationRepository authenticationRepository;
  final ErrorCubit errorCubit;

  RestInterceptor(this.authenticationRepository, this.errorCubit);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    if (authenticationRepository.isLogged()) {
      options.headers.addAll(
          {'Authorization': 'Bearer ${authenticationRepository.token}'});
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      authenticationRepository.logOut();
    }
    errorCubit.showRestError(err);
    handler.reject(err);
  }
}
