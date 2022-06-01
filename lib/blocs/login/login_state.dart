part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  final String email, password;
  final bool isHide;

  const LoginInitial({this.email = '', this.password = '', this.isHide = true});

  @override
  List<Object> get props => [email, password, isHide];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  @override
  List<Object> get props => [];
}
