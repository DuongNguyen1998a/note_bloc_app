part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLogin extends LoginEvent {
  final String email, password;
  final bool isHide;

  const DoLogin({this.email = '', this.password = '', this.isHide = true});

  @override
  List<Object?> get props => [email, password, isHide];
}

class TogglePassword extends LoginEvent {
  final bool isHide;

  const TogglePassword({this.isHide = true});

  @override
  List<Object?> get props => [isHide];
}

class ResetState extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
