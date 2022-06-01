import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiServices apiServices = ApiServices();
  LoginBloc() : super(const LoginInitial()) {
    on<DoLogin>(_onDoLogin);
    on<TogglePassword>(_onTogglePassword);
    on<ResetState>(_onResetState);
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    // call services
    final data = await apiServices.login(event.email, event.password);

    if (data != null) {
      emit(LoginSuccess());
      emit(const LoginInitial());
    }
    else {
      emit(LoginError());
      emit(const LoginInitial());
    }
  }

  Future<void> _onTogglePassword(TogglePassword event, Emitter<LoginState> emit) async {
    final state = this.state;

    if (state is LoginInitial) {
      emit(LoginInitial(isHide: !event.isHide));
    }
  }
  void _onResetState(ResetState event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
  }
}
