import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
part 'login_state_bloc.g.dart';


@CopyWith()
class LoginBlocState extends Equatable {
  const LoginBlocState({
    this.status = false,
    this.pwdVisibility = false,
    this.submissionInProgress = false,
    this.value = const {}
  });

  final bool status;
  final bool pwdVisibility;
  final bool submissionInProgress;
  final Map<String, dynamic> value;

  bool isValid() {
    return status;
  }

  @override
  List<Object> get props => [status, pwdVisibility, value];
}